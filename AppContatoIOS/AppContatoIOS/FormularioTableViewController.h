//
//  FormularioTableViewController.h
//  AppContatoIOS
//
//  Created by macbook on 14/12/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato+CoreDataClass.h"

@interface FormularioTableViewController : UITableViewController
@property (nonatomic, strong) Contato *contato;
@end
