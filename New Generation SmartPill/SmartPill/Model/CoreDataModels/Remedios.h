//
//  Remedios.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 12/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@class Lembrete, User;

@interface Remedios : NSManagedObject

@property (nonatomic, retain) NSString * apresentacao;
@property (nonatomic, retain) NSString * fabricante;
@property (nonatomic, retain) NSNumber * idRemedio;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * principioAtivo;
@property (nonatomic, retain) NSNumber * quantidade;
@property (nonatomic, retain) NSSet *lembretes;
@property (nonatomic, retain) NSSet *user;
@end

@interface Remedios (CoreDataGeneratedAccessors)

- (void)addLembretesObject:(Lembrete *)value;
- (void)removeLembretesObject:(Lembrete *)value;
- (void)addLembretes:(NSSet *)values;
- (void)removeLembretes:(NSSet *)values;

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet *)values;
- (void)removeUser:(NSSet *)values;

@end
