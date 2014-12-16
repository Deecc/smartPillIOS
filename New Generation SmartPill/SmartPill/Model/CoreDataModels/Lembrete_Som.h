//
//  Lembrete_Som.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 12/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lembrete;

@interface Lembrete_Som : NSManagedObject

@property (nonatomic, retain) NSNumber * idLembreteSom;
@property (nonatomic, retain) NSSet *lembretes;
@end

@interface Lembrete_Som (CoreDataGeneratedAccessors)

- (void)addLembretesObject:(Lembrete *)value;
- (void)removeLembretesObject:(Lembrete *)value;
- (void)addLembretes:(NSSet *)values;
- (void)removeLembretes:(NSSet *)values;

@end
