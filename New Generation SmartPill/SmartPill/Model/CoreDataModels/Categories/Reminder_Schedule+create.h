//
//  Reminder_Schedule+create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 22/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "Reminder_Schedule.h"
#import "Reminder+create.h"

@interface Reminder_Schedule (create)
+ (Reminder_Schedule *)reminderScheduleOfReminder:(Reminder *)reminder
                                         withDate:(NSDate*)date
                           inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)updateReminderSchedule:(Reminder_Schedule *)reminderSchedule
   fromDataBaseContext:(NSManagedObjectContext*)context;
@end
