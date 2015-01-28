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
    
    if (date) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Medicine"];
        request.predicate = [NSPredicate predicateWithFormat:@"name == %@",reminder.medicine.name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        if (!matches) {
            return nil;
        } else if (![matches count]) {
            reminderSchedule = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder_Schedule" inManagedObjectContext:context];
            if (reminder) {
                [reminderSchedule addReminderObject:reminder];
            }
            reminderSchedule.schedule = date;
        } else {
            for (Medicine * med in matches) {
                if ([med.reminder isEqual:reminder]) {
                    //REVER ESSE FIRST OBJECT
                    reminderSchedule = [[med.reminder allObjects]firstObject];
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
