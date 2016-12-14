//
//  Contato+CoreDataProperties.m
//  AppContatoIOS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "Contato+CoreDataProperties.h"

@implementation Contato (CoreDataProperties)

+ (NSFetchRequest<Contato *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contato"];
}

@dynamic email;
@dynamic nome;
@dynamic telefone;
@dynamic foto;

@end
