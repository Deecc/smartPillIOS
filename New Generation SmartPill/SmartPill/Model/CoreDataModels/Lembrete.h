//
//  Lembrete.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 12/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lembrete_Horarios, Lembrete_Som, Remedios;

@interface Lembrete : NSManagedObject

@property (nonatomic, retain) NSNumber * idLembrete;
@property (nonatomic, retain) Lembrete_Horarios *lembretes_horario;
@property (nonatomic, retain) Lembrete_Som *lembretes_som;
@property (nonatomic, retain) Remedios *remedios;

@end
