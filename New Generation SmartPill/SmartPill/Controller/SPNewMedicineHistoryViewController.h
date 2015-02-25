//
//  SPNewMedicineHistoryViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataViewController.h"

@interface SPNewMedicineHistoryViewController : SPCoreDataViewController


@property (strong,nonatomic) IBOutlet UIDatePicker *initialDate;
@property (strong,nonatomic) IBOutlet UIDatePicker *finalDate;
@property (strong, nonatomic) NSMutableArray *arrayBetweenDatesSelected;

-(IBAction)displayHistory:(UIBarButtonItem *)sender;


@end
