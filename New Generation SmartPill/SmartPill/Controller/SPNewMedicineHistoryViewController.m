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

-(IBAction)displayHistory:(UIButton *)sender{
    if ( [self isValidDates:self.today isDateBetween:self.dateInitial andDate:self.dateFinal] ){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Erro de seleção de data"
                                                     message:@"As data finais e iniciais, não podem ser maiores que a data de hoje, ou a data inicial não pode ser maior que a data final."
                                                     delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
        [theAlert show];
        [self alertView:theAlert clickedButtonAtIndex:0];
        
    }else [self performSegueWithIdentifier:@"MedicineHistorySegue" sender:sender];

    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Checks
    if (buttonIndex == 1) {
        //Retirar do banco
        NSLog(@"FUck Objective-C");
    }
}

- (NSDate*)today{
    _today = [[NSDate alloc] init];
    NSString *stringToday = [self.dateFormat stringFromDate:_today];
    return _today = [self.dateFormat dateFromString:stringToday];
}

- (NSString*)stringInitial{
    _stringInitial = [self.dateFormat stringFromDate:self.initialDate.date];
    return _stringInitial;
}

- (NSString*)stringFinal{
    _stringFinal = [self.dateFormat stringFromDate:self.finalDate.date];
    return _stringFinal;
}

-(NSDate*)dateInitial {
    _dateInitial = [self.dateFormat dateFromString:self.stringInitial];
    return _dateInitial;
}

- (NSDate*)dateFinal{
    _dateFinal = [self.dateFormat dateFromString:self.stringFinal];
    return _dateFinal;
}



- (NSDateFormatter*)dateFormat{
    _dateFormat = [[NSDateFormatter alloc]init];
    [_dateFormat setDateFormat:@"dd-MM-yyyy"];
    return _dateFormat;
}


- (BOOL) isReminderBetweenDates:(NSDate*)date isDateBetween:(NSDate*)initialDate andDate:(NSDate*)endDate{
    return (([date compare:initialDate] != NSOrderedAscending) && ([date compare:endDate] != NSOrderedDescending));
}

- (BOOL) isValidDates:(NSDate*)date isDateBetween:(NSDate*)initialDate andDate:(NSDate*)endDate {
    return (([date compare:initialDate] == NSOrderedAscending) ||
            ([date compare:endDate] == NSOrderedAscending) ||
            ([initialDate compare:endDate] == NSOrderedDescending));
}

- (NSMutableArray*)arrayBetweenDatesSelected{
    _arrayBetweenDatesSelected = [@[] mutableCopy];
  
    self.initialDate.date = [self.dateFormat dateFromString:self.stringInitial];
    self.finalDate.date = [self.dateFormat dateFromString:self.stringFinal];
    
    for (Reminder * arrayRem in self.reminders) {
            NSString *temp = [self.dateFormat stringFromDate:arrayRem.reminder_schedule.schedule];
            NSDate *tempDate = [self.dateFormat dateFromString:temp];
            if (([self isReminderBetweenDates:tempDate isDateBetween:self.initialDate.date andDate:self.finalDate.date])){
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
