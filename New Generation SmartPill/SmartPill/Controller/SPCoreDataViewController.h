//
//  SPCoreDataViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 04/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medicine+create.h"
#import "SPUserHandler.h"
#import "SPAppDelegate.h"
#import "Reminder_Schedule+create.h"
#import <CoreData/CoreData.h>

@interface SPCoreDataViewController : UIViewController<NSFetchedResultsControllerDelegate>
@property User * currentUser;
@property (strong,nonatomic) Medicine * medicine;
@property (strong,nonatomic) Reminder * reminder;
@property (strong,nonatomic) NSMutableArray * medicines;
@property (strong,nonatomic) NSMutableArray * reminders;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (SPUser*)getCurrentUser;
- (User*)getCurrentDatabaseUser;
- (Medicine*)getMedicineWithName:(NSString*)medicineName;
- (Medicine*)getMedicineWithDate:(NSDate*)date;
@end
