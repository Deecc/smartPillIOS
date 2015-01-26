//
//  Reminder+create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 22/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "Reminder.h"

@interface Reminder (create)

+ (Reminder *)reminderOfMedicine:(Medicine *)medicine
            withReminderSchedule:(Reminder_Schedule*)reminderSchedule
                   reminderSound:(Reminder_Sound*)reminderSound
          inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)updateReminder:(Reminder *)reminder
   fromDataBaseContext:(NSManagedObjectContext*)context;
@end
