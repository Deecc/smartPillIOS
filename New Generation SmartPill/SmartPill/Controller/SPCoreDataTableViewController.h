//
//  SPCoreDataTableViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 04/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminder+create.h"
#import "SPUserHandler.h"
#import "SPAppDelegate.h"

@interface SPCoreDataTableViewController : UITableViewController
@property (strong,nonatomic) Reminder * reminder;
@property (strong,nonatomic) NSMutableArray * medicines;
@property (strong,nonatomic) NSMutableArray * reminders;
@property (strong,nonatomic) NSManagedObjectContext * managedObjectContext;
@end
