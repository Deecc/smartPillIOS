//
//  Remedios+create.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "Remedios+create.h"



@implementation Remedios (create)

+ (Remedios *)medicineWithName:(NSString *)name
                  presentation:(NSString *)presentation
                        madeIn:(NSString *)factory
               activePrinciple:(NSString *)activePrinciple
                      quantity:(NSNumber *)quantity
                     reminders:(NSArray *)reminders
                          user:(User *)user
        inManagedObjectContext:(NSManagedObjectContext *)context{
    Remedios * medicine = nil;
    
    if ([name length]>0) {
     
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Remedios"];
        request.predicate = [NSPredicate predicateWithFormat:@"nome = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches) {
          
            return nil;
        } else if (![matches count]) {
           
            medicine = [NSEntityDescription insertNewObjectForEntityForName:@"Remedios"
                                                 inManagedObjectContext:context];
           
            medicine.nome = name;
            medicine.apresentacao = presentation;
            medicine.fabricante = factory;
            medicine.principioAtivo = activePrinciple;
            medicine.quantidade = [NSNumber numberWithInt:quantity];
            medicine.lembretes = reminders;
            [medicine addUserObject:user];
        } else {
            for (Remedios * med in matches) {
                if ([med.nome isEqualToString:name]) {
                    return med;
                }
            }
        }
    }
    
    return medicine;
}

@end
