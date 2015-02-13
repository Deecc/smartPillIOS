//
//  SPMedicineHistoryViewController.h
//  SmartPill
//
//  Created by deck on 13/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPMedicineHistoryViewController : UIViewController

@property (strong,nonatomic) IBOutlet UIDatePicker *initialDate;
@property (strong,nonatomic) IBOutlet UIDatePicker *finalDate;

-(IBAction)displayHistory:(UIBarButtonItem *)sender;


@end
