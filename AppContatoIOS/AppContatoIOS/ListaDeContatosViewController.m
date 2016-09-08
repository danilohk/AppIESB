//
//  ListaDeContatosViewController.m
//  AppContatoIOS
//
//  Created by macbook on 08/09/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "ListaDeContatosViewController.h"

@interface ListaDeContatosViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *lista;

@property (strong, nonatomic) NSArray<NSString *> *nomes;
@property (strong, nonatomic) NSArray<NSString *> *telefones;
@end

@implementation ListaDeContatosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lista setDataSource:self];
    
    self.nomes = @[@"Jose", @"Maria", @"Joaquim", @"Antonio"];
    self.telefones = @[@"(61) 99999-9988", @"(61) 99999-9977", @"(61) 99999-9966", @"(61) 99999-9955"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.nomes.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"celula"
                                    forIndexPath:indexPath];
    
    if (indexPath.row % 2) {
        [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:96.0/255.0 blue:65.0/255.0 alpha:255.0/255.0]];
    }else {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSString *nome = [self.nomes objectAtIndex:indexPath.row];
    NSString *telefone = [self.telefones objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:nome];
    
    [cell.textLabel setTextColor:[UIColor blackColor]];
    
    return cell;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
