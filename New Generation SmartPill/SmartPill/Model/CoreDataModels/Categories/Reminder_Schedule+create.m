//
//  Reminder_Schedule+create.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 22/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "Reminder_Schedule+create.h"

@implementation Reminder_Schedule (create)

+ (Reminder_Schedule *)reminderScheduleOfReminder:(Reminder *)reminder
                                         withDate:(NSDate*)date
                           inManagedObjectContext:(NSManagedObjectContext *)context{

    Reminder_Schedule * reminderSchedule = nil;
    
    if (reminder) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reminder_Schedule"];
        request.predicate = [NSPredicate predicateWithFormat:@"Reminder = %@", reminder];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches) {
            
            return nil;
        } else if (![matches count]) {
            
            reminderSchedule = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder_Schedule" inManagedObjectContext:context];
            [reminderSchedule addReminderObject:reminder];
            reminderSchedule.schedule = date;
        } else {
            for (Reminder_Schedule * remSchedule in matches) {
                if ([remSchedule.reminder isEqual:reminder]) {
                    return remSchedule;
                }
            }
        }
    }
    
    return reminderSchedule;
}

+ (void)updateReminderSchedule:(Reminder_Schedule *)reminderSchedule
           fromDataBaseContext:(NSManagedObjectContext*)context{
    //Fazer
}
@end
