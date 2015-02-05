//
//  SPNewReminderViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 23/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//


#import "Reminder+create.h"
#import "SPCoreDataViewController.h"
#import "SPTabBarViewController.h"

@interface SPNewReminderViewController : SPCoreDataViewController<UIPickerViewDataSource, UIPickerViewDelegate>
- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender;
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *medicinePicker;
@property (strong,nonatomic) NSMutableArray * medicineNamePicker;



@end
