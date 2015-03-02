//
//  SPMedicineHistoryViewController.h
//  SmartPill
//
//  Created by deck on 13/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataTableViewController.h"
#import "SPNewMedicineHistoryViewController.h"

@interface SPMedicineHistoryViewController : SPCoreDataTableViewController

 @property (strong, nonatomic) NSMutableArray *arrayBetweenDatesSelected;

@end
