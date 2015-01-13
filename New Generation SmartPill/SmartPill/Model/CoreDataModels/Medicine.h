//
//  Medicine.h
//  SmartPill
//
//  Created by Mobile School - Thiago on 13/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reminder, User;

@interface Medicine : NSManagedObject

@property (nonatomic, retain) NSString * availability;
@property (nonatomic, retain) NSString * manufacturer;
@property (nonatomic, retain) NSNumber * idMedicine;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * activeIngredient;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSSet *reminder;
@property (nonatomic, retain) NSSet *user;
@end

@interface Medicine (CoreDataGeneratedAccessors)

- (void)addReminderObject:(Reminder *)value;
- (void)removeReminderObject:(Reminder *)value;
- (void)addReminder:(NSSet *)values;
- (void)removeReminder:(NSSet *)values;

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet *)values;
- (void)removeUser:(NSSet *)values;

@end