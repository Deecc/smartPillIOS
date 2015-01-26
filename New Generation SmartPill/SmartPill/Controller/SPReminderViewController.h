//
//  SPReminderViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPAppDelegate.h"
#import "SPUserHandler.h"
#import "User.h"
#import "Medicine.h"
#import "Reminder.h"
#import "SPNewReminderViewController.h"
#import "SPReminderDetailsViewController.h"

@interface SPReminderViewController : UITableViewController

@property (strong,nonatomic) Reminder * reminder;

@end
