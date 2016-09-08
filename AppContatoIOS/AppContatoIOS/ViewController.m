//
//  ViewController.m
//  AppContatoIOS
//
//  Created by ALUNO on 10/08/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)logar:(id)sender{
    if ([usuario.text isEqualToString:@"usuario"] && [senha.text isEqualToString:@"senha"]) {
        
        [self performSegueWithIdentifier: @"listar" sender: self];
        
    } else {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"ERRO" message:@"usuário ou senha incorretos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
