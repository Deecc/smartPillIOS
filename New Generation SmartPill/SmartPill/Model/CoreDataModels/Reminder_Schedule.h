//
//  Reminder_Schedule.h
//  SmartPill
//
//  Created by Mobile School - Julian on 1/29/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reminder;

@interface Reminder_Schedule : NSManagedObject

@property (nonatomic, retain) NSNumber * idReminderSchedule;
@property (nonatomic, retain) NSDate * schedule;
@property (nonatomic, retain) NSSet *reminder;
@end

@interface Reminder_Schedule (CoreDataGeneratedAccessors)

- (void)addReminderObject:(Reminder *)value;
- (void)removeReminderObject:(Reminder *)value;
- (void)addReminder:(NSSet *)values;
- (void)removeReminder:(NSSet *)values;

@end
