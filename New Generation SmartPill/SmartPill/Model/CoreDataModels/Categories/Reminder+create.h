//
//  Reminder+create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 22/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "Reminder.h"
#import "Reminder_Schedule+create.h"
@interface Reminder (create)

+ (Reminder *)reminderOfMedicine:(Medicine *)medicine
            withReminderSchedule:(Reminder_Schedule*)reminderSchedule
                   reminderSound:(Reminder_Sound*)reminderSound
          inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)updateOldReminder:(Reminder *)oldReminder
            toNewReminder:(Reminder*)newReminder
      fromDataBaseContext:(NSManagedObjectContext*)context;
@end
