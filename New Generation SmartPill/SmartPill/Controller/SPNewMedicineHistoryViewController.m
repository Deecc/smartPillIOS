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

- (NSString*)stringInitial{
    _stringInitial = [self.dateFormat stringFromDate:self.initialDate.date];
    return _stringInitial;
}

- (NSString*)stringFinal{
    _stringFinal = [self.dateFormat stringFromDate:self.finalDate.date];
    return _stringFinal;
}

- (NSDateFormatter*)dateFormat{
    _dateFormat = [[NSDateFormatter alloc]init];
    [_dateFormat setDateFormat:@"dd-MM-yyyy"];
    return _dateFormat;
}

- (BOOL) isReminderBetweenDifDates:(NSDate*)date isDateBetween:(NSDate*)initialDate andDate:(NSDate*)endDate{
    return (([date compare:initialDate] != NSOrderedAscending) && ([date compare:endDate] != NSOrderedDescending));
    
}

- (BOOL) isReminderBetweenSameDates:(NSDate*)date isDateBetween:(NSDate*)initialDate andDate:(NSDate*)endDate{
    return (([date compare:initialDate] == NSOrderedSame) && ([date compare:endDate] == NSOrderedSame));
    
}


- (NSMutableArray*)arrayBetweenDatesSelected{
    _arrayBetweenDatesSelected = [@[] mutableCopy];
    
    self.initialDate.date = [self.dateFormat dateFromString:self.stringInitial];
    self.finalDate.date = [self.dateFormat dateFromString:self.stringFinal];
    
    NSLog(@"initial: %@ , final %@", self.initialDate.date, self.finalDate.date);
    //NSLog(@"initialString: %@ , finalString %@", self.stringInitial, self.stringFinal);
    
    for (Reminder * arrayRem in self.reminders) {
        NSString *temp = [self.dateFormat stringFromDate:arrayRem.reminder_schedule.schedule];
        NSDate *tempDate = [self.dateFormat dateFromString:temp];
        NSLog(@"Data lembrete %@", arrayRem.reminder_schedule.schedule );
        if (([self isReminderBetweenDifDates:tempDate isDateBetween:self.initialDate.date andDate:self.finalDate.date])){
            NSLog(@"Datas Diferentes");
           // [_arrayBetweenDatesSelected addObject:arrayRem];
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
