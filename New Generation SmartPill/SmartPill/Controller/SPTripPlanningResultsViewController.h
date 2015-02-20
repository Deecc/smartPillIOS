//
//  SPTripPlanningResultsViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataTableViewController.h"

@interface SPTripPlanningResultsViewController : SPCoreDataTableViewController

@property (nonatomic)  NSMutableArray * selectedReminders;
@property (nonatomic)  NSMutableArray * resultOfMedicineQuantities;
@property NSNumber * numberOfTripDays;

@end
