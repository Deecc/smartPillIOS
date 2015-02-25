//
//  SPNewMedicineHistoryViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPNewMedicineHistoryViewController.h"

@interface SPNewMedicineHistoryViewController ()



@end

@implementation SPNewMedicineHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)displayHistory:(UIBarButtonItem *)sender{
    [self arrayBetweenDatesSelectedAtStart];
}

- (NSMutableArray*)arrayBetweenDatesSelectedAtStart{
    _arrayWithDatesRange = [@[]mutableCopy];
    
    for (Reminder * arrayRem in self.reminders) {
        if ((arrayRem.reminder_schedule.schedule > self.initialDate.date) &&
            (arrayRem.reminder_schedule.schedule < self.finalDate.date)) {
            [_arrayWithDatesRange addObject:arrayRem.reminder_schedule.reminder];
        }
    }
    return _arrayWithDatesRange;
}



@end
