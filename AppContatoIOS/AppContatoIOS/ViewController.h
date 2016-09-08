//
//  ViewController.h
//  AppContatoIOS
//
//  Created by ALUNO on 10/08/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UITextField *usuario;
    IBOutlet UITextField *senha;
}
- (IBAction)logar:(id)sender;

@end

