//
//  Remedios+create.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "Medicine+create.h"



@implementation Medicine (create)

+ (Medicine *)medicineWithName:(NSString *)name
                  availability:(NSString *)availability
                        manufactuary:(NSString *)manufactuary
               activeIngredient:(NSString *)activeIngredient
                      quantity:(NSNumber *)quantity
                     reminder:(NSSet *)reminder
                          user:(User *)user
        inManagedObjectContext:(NSManagedObjectContext *)context{
    Medicine * medicine = nil;
    
    if ([name length]>0) {
     
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Medicine"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches) {
          
            return nil;
        } else if (![matches count]) {
           
            medicine = [NSEntityDescription insertNewObjectForEntityForName:@"Medicine"
                                                 inManagedObjectContext:context];
           
            medicine.name = name;
            medicine.availability = availability;
            medicine.manufacturer = manufactuary;
            medicine.activeIngredient = activeIngredient;
            medicine.quantity = quantity;
            medicine.reminder = reminder;
            [medicine addUserObject:user];
        } else {
            for (Medicine * med in matches) {
                if ([med.name isEqualToString:name]) {
                    return med;
                }
            }
        }
    }
    
    return medicine;
}

@end
