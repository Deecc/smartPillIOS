//
//  SPNewMedicineHistoryViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPNewMedicineHistoryViewController.h"
#import "SPMedicineHistoryViewController.h"

@interface SPNewMedicineHistoryViewController ()



@end

@implementation SPNewMedicineHistoryViewController

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

-(IBAction)displayHistory:(UIBarButtonItem *)sender{
    
}

- (NSMutableArray*)arrayBetweenDatesSelected{
    _arrayBetweenDatesSelected = [@[] mutableCopy];
    NSLog(@"array reminder = %@",self.reminders);
    for (Reminder * arrayRem in self.reminders) {
        if ((arrayRem.reminder_schedule.schedule >= self.initialDate.date) &&
            (arrayRem.reminder_schedule.schedule <= self.finalDate.date)) {
            [_arrayBetweenDatesSelected addObject:arrayRem];
        }
    }
    NSLog(@"%@",_arrayBetweenDatesSelected);
    for (Reminder * rem in _arrayBetweenDatesSelected) {
        NSLog(@"remedio do reminder = %@",rem.medicine.name);
        NSLog(@"data do remedio = %@",rem.reminder_schedule.schedule);
    }
    return _arrayBetweenDatesSelected;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MedicineHistorySegue"]) {
        SPMedicineHistoryViewController * mHVC = segue.destinationViewController;
        mHVC.arrayBetweenDatesSelected = self.arrayBetweenDatesSelected;
        
    }

}
@end
