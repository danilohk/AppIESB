//
//  Contato+CoreDataProperties.h
//  AppContatoIOS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "Contato+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contato (CoreDataProperties)

+ (NSFetchRequest<Contato *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *nome;
@property (nullable, nonatomic, copy) NSString *telefone;
@property (nullable, nonatomic, retain) NSData *foto;

@end

NS_ASSUME_NONNULL_END
