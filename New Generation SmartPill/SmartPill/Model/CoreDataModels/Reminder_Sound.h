//
//  Reminder_Sound.h
//  SmartPill
//
//  Created by Mobile School - Thiago on 13/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reminder;

@interface Reminder_Sound : NSManagedObject

@property (nonatomic, retain) NSNumber * idReminderSound;
@property (nonatomic, retain) NSSet *reminder;
@end

@interface Reminder_Sound (CoreDataGeneratedAccessors)

- (void)addReminderObject:(Reminder *)value;
- (void)removeReminderObject:(Reminder *)value;
- (void)addReminder:(NSSet *)values;
- (void)removeReminder:(NSSet *)values;

@end
