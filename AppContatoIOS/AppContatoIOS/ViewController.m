//
//  ViewController.m
//  AppContatoIOS
//
//  Created by ALUNO on 10/08/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Contato+CoreDataClass.h"

@interface ViewController () <NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *botao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoCentro;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usuarioCentro;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *senhaCentro;
@property (strong, nonatomic) NSMutableData *bytesResposta;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBotaoAcessar;

@end

@implementation ViewController{
    CGFloat valorOriginalConstanteBotaoAcessar;
}

static NSString * const kChaveBancoCarregado = @"bancoCarregado";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    valorOriginalConstanteBotaoAcessar = _constraintBotaoAcessar.constant;
    
    _bytesResposta = [NSMutableData new];
    
    self.logoCentro.constant = self.view.frame.size.width * (-1) - (100);
    self.usuarioCentro.constant = self.view.frame.size.width * (-1) - (100);
    self.senhaCentro.constant = self.view.frame.size.width * (-1) - (100);

    
    self.botao.alpha = 0.0;
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tecladoApareceu:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tecladoSumiu:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:2
            delay:0
            options:UIViewAnimationOptionCurveLinear
            animations:^{
                self.logoCentro.constant = 0;
                [self.view layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1
                        delay:0
                        options:UIViewAnimationOptionCurveLinear
                        animations:^{
                            self.usuarioCentro.constant = 0;
                            
                            [self.view layoutIfNeeded];
                            
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:1
                                    delay:0
                                    options:UIViewAnimationOptionCurveLinear
                                    animations:^{
                                        
                                        self.senhaCentro.constant = 0;
                                        [self.view layoutIfNeeded];
                                        
                                    } completion:^(BOOL finished) {
                                        [UIView animateWithDuration:2
                                                delay:0
                                                options:UIViewAnimationOptionCurveLinear
                                                animations:^{
                                                    
                                                    self.botao.alpha = 1.0;
                                                    
                                                } completion:^(BOOL finished) {
                                                    
                                                }];
                                    }];
                        }];
            }];
            [self primeiraCarga];
    
}
    
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

- (void) tecladoApareceu: (NSNotification *) sender {
    NSDictionary* dicionarioDeInformacoesSobreTeclado = [sender userInfo];
    CGRect frameDoTeclado = [[dicionarioDeInformacoesSobreTeclado valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [_constraintBotaoAcessar setConstant: (valorOriginalConstanteBotaoAcessar + frameDoTeclado.size.height)];
    
}

- (void) tecladoSumiu: (NSNotification *) sender {
    [_constraintBotaoAcessar setConstant:valorOriginalConstanteBotaoAcessar];
}


- (IBAction)logar:(id)sender{
    if ([usuario.text isEqualToString:@"usuario"] && [senha.text isEqualToString:@"senha"]) {
        
        [self performSegueWithIdentifier: @"listar" sender: self];
        
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ERRO" message:@"suário ou senha incorretos" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:ok];
        
        /*[self presentViewController:alertController animated:YES completion:nil];
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"ERRO" message:@"usuário ou senha incorretos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];*/
    }
}


- (void) primeiraCarga {
    
    BOOL bancoCarregado = [[NSUserDefaults standardUserDefaults] boolForKey:kChaveBancoCarregado];
    
    if (!bancoCarregado) {
        
        NSURLSessionConfiguration *sc = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sc
                                                              delegate:self
                                                         delegateQueue:nil];
        /*http://jsonplaceholder.typicode.com/users*/
        
        NSURLSessionDataTask *task =
        [session dataTaskWithURL:[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"]];
        
        [task resume];
        
    }
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    [_bytesResposta appendData:data];
}


- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    
    if (error) {
        NSLog(@"Erro de conexão: %@", error);
    }else {
        NSError *erroJSON;
        
        NSArray<NSDictionary *> *usuarios =
        [NSJSONSerialization JSONObjectWithData:_bytesResposta
                                        options:kNilOptions
                                          error:&erroJSON];
        
        if (erroJSON) {
            NSLog(@"JSON recebido é inválido: %@", erroJSON);
        }else {
            BOOL bancoCarregado = [[NSUserDefaults standardUserDefaults] boolForKey:kChaveBancoCarregado];
            if (!bancoCarregado) {
            
                AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
                NSPersistentContainer *containerPersistencia = delegate.persistentContainer;
                NSManagedObjectContext *ctx = containerPersistencia.viewContext;
                
                NSURLSessionConfiguration *sc = [NSURLSessionConfiguration defaultSessionConfiguration];
                NSURLSession *session = [NSURLSession sessionWithConfiguration:sc
                                                                      delegate:self
                                                                 delegateQueue:nil];
                NSURLSessionDownloadTask *fotoTask = nil;
            
                for (NSDictionary *user in usuarios) {
                
                    Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                                                 inManagedObjectContext:ctx];
                
                    [contato setNome: [user objectForKey:@"name"]];
                    [contato setEmail: [user objectForKey:@"email"]];
                    [contato setTelefone: [user objectForKey:@"phone"]];
                    
                    fotoTask = [session downloadTaskWithURL:[NSURL URLWithString:@"http://lorempixel.com/200/200/people/"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                            NSData *data = [NSData dataWithContentsOfURL: location];
                            [contato setFoto: data];
                    }];
                    
                    [fotoTask resume];
                }
            
                NSError *erroCoreData;
                if (![ctx save:&erroCoreData]) {
                    NSLog(@"\n\n\nErro ao realizar carga inicial: %@ \n\n\n", erroCoreData);
                }else {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kChaveBancoCarregado];
                }
            }
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
