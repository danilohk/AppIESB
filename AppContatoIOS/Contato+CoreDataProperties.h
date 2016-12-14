//
//  Contato+CoreDataProperties.h
//  AppContatoIOS
//
//  Created by macbook on 14/12/16.
//  Copyright © 2016 ALUNO. All rights reserved.
//

#import "Contato+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contato (CoreDataProperties)

+ (NSFetchRequest<Contato *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, retain) NSData *foto;
@property (nullable, nonatomic, copy) NSString *nome;
@property (nullable, nonatomic, copy) NSString *telefone;
@property (nullable, nonatomic, copy) NSString *endereco;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;

@end

NS_ASSUME_NONNULL_END
