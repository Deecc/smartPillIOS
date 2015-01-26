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

+ (void)updateMedicine:(Medicine *)medicine fromDataBaseContext:(NSManagedObjectContext*)context{
   
    if ([medicine.name length]>0) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Medicine"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", medicine.name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches) {
            NSLog(@"Error in Update Medicine");
            return;
        } else if ([matches count]) {
            for (Medicine * med in matches) {
                if ([med.name isEqualToString:medicine.name]) {
                    med.name = medicine.name;
                    med.availability = medicine.availability;
                    med.manufacturer =medicine.manufacturer;
                    med.activeIngredient = medicine.activeIngredient;
                    med.quantity = medicine.quantity;
                    med.reminder = medicine.reminder;
                }
            }
        }else if(![matches count]){
            NSLog(@"Could not find any medicine in the database");
        
        }
        
    }
    [context save:nil];
}

@end
