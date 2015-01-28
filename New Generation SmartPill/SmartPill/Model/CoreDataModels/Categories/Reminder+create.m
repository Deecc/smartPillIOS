//
//  Reminder+create.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 22/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "Reminder+create.h"

@implementation Reminder (create)

- (NSString*)description{
    NSString * string = [NSString stringWithFormat:@"Medicine = %@, and Reminder Schedule = %@",self.medicine.name,self.reminder_schedule.schedule];
    return string;
}

+ (Reminder *)reminderOfMedicine:(Medicine *)medicine
            withReminderSchedule:(Reminder_Schedule*)reminderSchedule
                   reminderSound:(Reminder_Sound*)reminderSound
          inManagedObjectContext:(NSManagedObjectContext *)context{
    
    Reminder * reminder = nil;
    
    if (medicine) {
        
        NSString * medicineName = medicine.name;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Medicine"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", medicineName];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches) {
            
            return nil;
        } else if (![matches count]) {
            return nil;
        } else {
            for (Medicine * med in matches) {
                if ([med.name isEqualToString:medicineName]) {
                    reminder = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder"
                                                             inManagedObjectContext:context];
                    reminder.medicine = med;
                    reminder.reminder_schedule = reminderSchedule;
                    reminder.reminder_sound = reminderSound;
                    
                    return reminder;
                }
            }
        }
    }
    return nil;
}

+ (void)updateOldReminder:(Reminder *)oldReminder
            toNewReminder:(Reminder*)newReminder
      fromDataBaseContext:(NSManagedObjectContext*)context{

    if (oldReminder) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Medicine"];
        request.predicate = [NSPredicate predicateWithFormat:@"ANY reminder = %@", oldReminder];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches) {
            NSLog(@"Error in Update Medicine");
            return;
        } else if ([matches count]) {
            for (Reminder * rem in matches) {
                if ([rem isEqual:oldReminder]) {
                    rem.reminder_schedule = newReminder.reminder_schedule;
                    if(rem.reminder_sound){rem.reminder_sound = newReminder.reminder_sound;}
                    rem.medicine = newReminder.medicine;
                }
            }
        }else if(![matches count]){
            NSLog(@"Could not find any medicine in the database");
            
        }
        
    }
    [context save:nil];
}

@end
