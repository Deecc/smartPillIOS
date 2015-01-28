//
//  SPNewReminderViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 23/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminder+create.h"
#import "User.h"
#import "Reminder_Schedule+create.h"

@interface SPNewReminderViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong,nonatomic) Reminder * reminder;
@property (strong,nonatomic) NSMutableArray * medicines;
- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender;
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *medicinePicker;
@property (strong,nonatomic) NSMutableArray * medicineNamePicker;
- (Medicine*)getMedicineWithName:(NSString*)medicineName;


@end
