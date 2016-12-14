//
//  FormularioTableViewController.m
//  AppContatoIOS
//
//  Created by macbook on 14/12/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//


#import "FormularioTableViewController.h"
#import "AppDelegate.h"
#import "Contato+CoreDataClass.h"
@import MobileCoreServices;
@import Photos;

@interface FormularioTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *teleone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIImageView *foto;
@property (weak, nonatomic) IBOutlet UIImageView *tirarFoto;
@property (weak, nonatomic) IBOutlet UIImageView *abrirFoto;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;

@end

@implementation FormularioTableViewController {
    CGFloat valorOriginalConstanteBotaoAcessar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.contato) {
        [self.nome setText:[self.contato valueForKey:@"nome"]];
        [self.teleone setText:[self.contato valueForKey:@"telefone"]];
        [self.email setText:[self.contato valueForKey:@"email"]];
        [self.endereco setText:[self.contato valueForKey:@"endereco"]];
        [self.latitude setText:[self.contato valueForKey:@"latitude"]];
        [self.longitude setText:[self.contato valueForKey:@"longitude"]];
        
        if([self.contato valueForKey:@"foto"] != nil){
            [self.foto setImage:[UIImage imageWithData:[self.contato valueForKey:@"foto"]]];
        }
    }
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Salvar"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(salvarContato:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //tap gesture para as imagens
    _tirarFoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapTirarFoto = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tirarFoto:)];
    tapTirarFoto.numberOfTapsRequired = 1;
    [_tirarFoto addGestureRecognizer:tapTirarFoto];
    
    _abrirFoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapAbrirFoto = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(abrirFoto:)];
    tapAbrirFoto.numberOfTapsRequired = 1;
    [_abrirFoto addGestureRecognizer:tapAbrirFoto];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)tirarFoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [UIImagePickerController new];
        [picker setDelegate:self];
        [picker setAllowsEditing:YES];
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [picker setShowsCameraControls:YES];
        [picker setMediaTypes:@[((NSString *) kUTTypeImage), ((NSString *) kUTTypeMovie)]]; //Veja as outras opções.
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Use um iPhone"
                                                                    message:@"É necessário um dispositivo físico que possua câmera."
                                                             preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"OK"
                                               style:UIAlertActionStyleCancel
                                             handler:nil]];
        
        [self presentViewController:ac animated:YES completion:nil];
    }
    
}
- (void)abrirFoto:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    //Todos os tipos disponíveis:
    [picker setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]];
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(IBAction)salvarContato:(UIButton *)sender {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    if (self.contato) {
        [self.contato setNome:self.nome.text];
        [self.contato setTelefone:self.teleone.text];
        [self.contato setEmail:self.email.text];
        [self.contato setEndereco:self.endereco.text];
        [self.contato setLatitude:self.latitude.text];
        [self.contato setLongitude:self.longitude.text];
        [self.contato setFoto:UIImagePNGRepresentation(self.foto.image)];
        
    } else {
        Contato *novoContato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:context];
        [novoContato setNome:self.nome.text];
        [novoContato setTelefone:self.teleone.text];
        [novoContato setEmail:self.email.text];
        [novoContato setEndereco:self.endereco.text];
        [novoContato setLatitude:self.latitude.text];
        [novoContato setLongitude:self.longitude.text];
        [novoContato setFoto:UIImagePNGRepresentation(self.foto.image)];
    }
    
    NSError *erroCoreData;
    if (![context save:&erroCoreData]) {
        NSLog(@"\n\n\nErro ao salvar o contato! %@\n\n\n", erroCoreData);
    }
    else {
        NSLog(@"\n\n\nContato salvo com sucesso!\n\n\n");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *imagemEscolhida = info[UIImagePickerControllerEditedImage]; //Veja as outras opções.
    
    //Você vai precisar disso para o exercício
    NSData *bytesDaImagem = UIImagePNGRepresentation(imagemEscolhida);
    
    //Para converter de volta
    UIImage *imagem = [UIImage imageWithData:bytesDaImagem];
    
    [self.foto setImage: imagem];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"Usuário cancelou.");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180; //retornar aqui a altura estimada da célula... olhe no XIB a altura.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension; //isso faz a tableView aceitar células com alturas dinâmicas
}

@end

