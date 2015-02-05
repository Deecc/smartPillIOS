//
//  SPScheduleViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataViewController.h"
#import "SPMedicineDetailsViewController.h"

@interface SPScheduleViewController : SPCoreDataViewController< UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray *pastReminders;
@property (strong,nonatomic) NSMutableArray *futureReminders;
@end
