//
//  SPScheduleViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataTableViewController.h"
#import "SPMedicineDetailsViewController.h"
#import "SPNewReminderViewController.h"
#import "SPAddPrescription.h"

@interface SPScheduleViewController : SPCoreDataTableViewController
@property (strong,nonatomic) NSMutableArray *pastReminders;
@property (strong,nonatomic) NSMutableArray *futureReminders;
@end
