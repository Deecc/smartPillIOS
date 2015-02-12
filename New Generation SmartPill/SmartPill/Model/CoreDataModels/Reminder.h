//
//  Reminder.h
//  SmartPill
//
//  Created by Mobile School - Julian on 1/29/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medicine, Reminder_Schedule, Reminder_Sound;

@interface Reminder : NSManagedObject

@property (nonatomic, retain) NSNumber * idReminder;
@property (nonatomic, retain) Medicine *medicine;
@property (nonatomic, retain) Reminder_Schedule *reminder_schedule;
@property (nonatomic, retain) Reminder_Sound *reminder_sound;

@end
