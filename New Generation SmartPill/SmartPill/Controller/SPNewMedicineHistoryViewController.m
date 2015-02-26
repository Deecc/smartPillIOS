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
//    NSString *final = [self.dateFormat stringFromDate:self.finalDate.date];
//    NSDate *today = [[NSDate alloc]init];
//    if (final > today){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data final incorreta!"
//                                                           message:@"Sua data final não pode ser maior do que a data de hoje."
//                                                          delegate:self
//                                                 cancelButtonTitle:@"Ok"
//                                                 otherButtonTitles:nil];
//        [alert show];
//    }
}

- (NSString*)stringInitial{
    _stringInitial = [_dateFormat stringFromDate:self.initialDate.date];
    return _stringInitial;
}

- (NSString*)stringFinal{
    _stringFinal = [_dateFormat stringFromDate:self.finalDate.date];
    return _stringFinal;
}

- (NSDateFormatter*)dateFormat{
    _dateFormat = [[NSDateFormatter alloc]init];
    [_dateFormat setDateFormat:@"dd-MM-yyyy"];
    return _dateFormat;
}


- (NSMutableArray*)arrayRemindersOnlyDates{
    _arrayRemindersOnlyDates = [@[] mutableCopy];
    for (Reminder * arrayRem in self.reminders) {
        
        [_arrayRemindersOnlyDates addObject:[_dateFormat stringFromDate:arrayRem.reminder_schedule.schedule]];
    }
    return _arrayRemindersOnlyDates;
}

- (NSMutableArray*)arrayBetweenDatesSelected{
    _arrayBetweenDatesSelected = [@[] mutableCopy];
    
    NSLog(@"initial: %@ , final %@", _stringInitial, _stringFinal);
    
//    NSString * stringInitial = [self.dateFormat stringFromDate:self.initialDate.date];
//    NSString * stringFinal = [self.dateFormat stringFromDate:self.finalDate.date];
    
    for (Reminder * arrayRem in self.reminders) {
        NSString * arrayDates = [_dateFormat stringFromDate:arrayRem.reminder_schedule.schedule];
        if (( [self.dateFormat dateFromString:arrayDates] >= [self.dateFormat dateFromString:_stringInitial] ) &&
            ([self.dateFormat dateFromString:arrayDates] <= [self.dateFormat dateFromString:_stringFinal])) {
            [_arrayBetweenDatesSelected addObject:arrayRem];
        }
    }
    return _arrayBetweenDatesSelected;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MedicineHistorySegue"]) {
        SPMedicineHistoryViewController * medicineHistoryVC = segue.destinationViewController;
        medicineHistoryVC.arrayBetweenDatesSelected = self.arrayBetweenDatesSelected;
        
    }

}






@end
