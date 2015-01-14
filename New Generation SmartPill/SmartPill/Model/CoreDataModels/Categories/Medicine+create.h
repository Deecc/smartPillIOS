//
//  Remedios+create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "Medicine.h"

@interface Medicine (create)
+ (Medicine *)medicineWithName:(NSString *)name
                  availability:(NSString *)availability
                        manufactuary:(NSString *)manufactuary
               activeIngredient:(NSString *)activeIngredient
                      quantity:(NSNumber *)quantity
                     reminder:(NSSet *)reminder
                          user:(User*)user
        inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)updateMedicine:(Medicine *)medicine fromDataBaseContext:(NSManagedObjectContext*)context;
@end
