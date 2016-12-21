//
//  ContatoTableViewCell.h
//  AppContatoIOS
//
//  Created by macbook on 15/11/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContatoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fotoPerfil;
@property (weak, nonatomic) IBOutlet UILabel *NomeContato;
@property (weak, nonatomic) IBOutlet UILabel *telefone;
@property (weak, nonatomic) IBOutlet UIImageView *foto;
@property (weak, nonatomic) IBOutlet UILabel *email;

@end
