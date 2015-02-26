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
    _stringInitial = [self.dateFormat stringFromDate:self.initialDate.date];
    NSLog(@"stringInitial = %@", _stringInitial);
    return _stringInitial;
}

- (NSString*)stringFinal{
    _stringFinal = [self.dateFormat stringFromDate:self.finalDate.date];
     NSLog(@"stringFinal = %@", _stringFinal);
    return _stringFinal;
}

- (NSDateFormatter*)dateFormat{
    _dateFormat = [[NSDateFormatter alloc]init];
    [_dateFormat setDateFormat:@"dd-MM-yyyy"];
    return _dateFormat;
}

- (BOOL) isReminderBetweenDates:(NSDate*)date isDateBetween:(NSDate*)initialDate andDate:(NSDate*)endDate{
    NSDate *today = [NSDate date];
    return (([date compare:initialDate] == NSOrderedDescending) && ([date compare:endDate] == NSOrderedAscending) && ([date isEqualToDate:today]));
 
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
    
    NSLog(@"initial: %@ , final %@", self.initialDate.date, self.finalDate.date);

    
    for (Reminder * arrayRem in self.reminders) {
        if ([self isReminderBetweenDates:arrayRem.reminder_schedule.schedule isDateBetween:self.initialDate.date andDate:self.finalDate.date] ){
            [_arrayBetweenDatesSelected addObject:arrayRem];
        }
        
    }
           // NSString * arrayDates = [self.dateFormat stringFromDate:arrayRem.reminder_schedule.schedule];
            
//            if (( [self.dateFormat dateFromString:arrayDates] >= [self.dateFormat dateFromString:self.stringInitial] ) &&
//                ([self.dateFormat dateFromString:arrayDates] <= [self.dateFormat dateFromString:self.stringFinal])) {
//                [_arrayBetweenDatesSelected addObject:arrayRem];
//            }
        //}
        
        for (Reminder *rem in _arrayBetweenDatesSelected) {
            NSLog(@"Remedio = %@", rem.medicine.name);
            NSLog(@"Data = %@", rem.reminder_schedule.schedule);
        }

//    NSLog(@"initial: %@ , final %@", self.stringInitial, self.stringFinal);
    
//    NSString * stringInitial = [self.dateFormat stringFromDate:self.initialDate.date];
//    NSString * stringFinal = [self.dateFormat stringFromDate:self.finalDate.date];
    
    
    
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
