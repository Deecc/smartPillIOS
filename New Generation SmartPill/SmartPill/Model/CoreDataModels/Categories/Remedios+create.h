//
//  Remedios+create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "Remedios.h"

@interface Remedios (create)
+ (Remedios *)medicineWithName:(NSString *)name
                  presentation:(NSString *)presentation
                        madeIn:(NSString *)factory
               activePrinciple:(NSString *)activePrinciple
                      quantity:(NSNumber *)quantity
                     reminders:(NSArray *)reminders
                          user:(User*)user
        inManagedObjectContext:(NSManagedObjectContext *)context;
@end
