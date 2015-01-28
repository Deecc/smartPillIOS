//
//  SPReminderDetailsViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 23/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminder.h"
#import "SPNewReminderViewController.h"

@interface SPReminderDetailsViewController : UIViewController

@property (strong,nonatomic) Reminder * reminder;
- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelMedicineName;
@property (weak, nonatomic) IBOutlet UILabel *labelReminderTime;
@property (weak, nonatomic) IBOutlet UILabel *labelSongName;

@end
