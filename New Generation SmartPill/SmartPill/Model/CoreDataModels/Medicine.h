//
//  Medicine.h
//  SmartPill
//
//  Created by Mobile School - Julian on 1/29/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe, Reminder, User;

@interface Medicine : NSManagedObject

@property (nonatomic, retain) NSString * activeIngredient;
@property (nonatomic, retain) NSString * availability;
@property (nonatomic, retain) NSNumber * idMedicine;
@property (nonatomic, retain) NSString * manufacturer;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSSet *reminder;
@property (nonatomic, retain) NSSet *user;
@property (nonatomic, retain) Recipe *recipe;
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
