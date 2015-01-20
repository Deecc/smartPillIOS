//
//  Medicine.h
//  SmartPill
//
//  Created by Mobile School - Thiago on 20/01/15.
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
@property (nonatomic, retain) UNKNOWN_TYPE attribute;
@property (nonatomic, retain) UNKNOWN_TYPE attribute1;
@property (nonatomic, retain) NSSet *reminder;
@property (nonatomic, retain) NSSet *user;
@property (nonatomic, retain) NSSet *recipe;
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

- (void)addRecipeObject:(Recipe *)value;
- (void)removeRecipeObject:(Recipe *)value;
- (void)addRecipe:(NSSet *)values;
- (void)removeRecipe:(NSSet *)values;

@end
