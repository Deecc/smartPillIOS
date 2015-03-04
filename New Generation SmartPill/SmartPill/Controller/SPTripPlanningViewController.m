//
//  SPTripPlanningViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 12/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPTripPlanningViewController.h"

@interface SPTripPlanningViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (nonatomic)  NSMutableArray * selectedReminders;
@property (nonatomic)  NSMutableArray * resultOfMedicineQuantities;
@end

@implementation SPTripPlanningViewController

- (NSMutableArray*)selectedMedicines{

    if (!_selectedReminders) {
        _selectedReminders = [@[] mutableCopy];
    }
    return _selectedReminders;
}

- (NSMutableArray*)resultOfMedicineQuantities{
    
    if (!_resultOfMedicineQuantities) {
        _resultOfMedicineQuantities = [@[] mutableCopy];
    }
    return _resultOfMedicineQuantities;
}

#pragma mark - Table view data source

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reminders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Reminder *reminder = [self.reminders objectAtIndex:indexPath.row];
    
    NSDate * date = reminder.reminder_schedule.schedule;
    NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setDateFormat:@"HH:mm"];
    if ([self.resultOfMedicineQuantities count]>0) {
        NSString * numberOfSelectedReminder = @"";
        
        for (NSInteger x = 0; x<=[self.selectedMedicines count]-1; x++) {
            Reminder* reminderSelected = [self.selectedMedicines objectAtIndex:x];
            if ([reminderSelected isEqual: reminder]) {
                numberOfSelectedReminder = [NSString stringWithFormat:@"+%@ unidades",[self.resultOfMedicineQuantities objectAtIndex:x]];
            }
        }
        
        NSString * description = [NSString stringWithFormat:@"%@                 %@",[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]],numberOfSelectedReminder];
        [cell.detailTextLabel setText:description];
    }else{
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
    }
    [cell.textLabel setText:[[reminder valueForKey:@"medicine"]valueForKey:@"name"]];
    
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)deleteNotification:(NSIndexPath *)indexPath{
    
    Reminder * reminder = [self.reminders objectAtIndex:indexPath.row];
    Medicine * medicine = reminder.medicine;
    Reminder_Schedule * schedule = reminder.reminder_schedule;
    
    //Delete notification
    NSDictionary * uidToDelete = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat: @"%@",medicine.name ], @"medicineName", schedule.schedule, @"date", nil];
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary * uid = oneEvent.userInfo;
        if ([[uid valueForKey:@"medicineName"] isEqual:[uidToDelete valueForKey:@"medicineName"]])
        {
            if ([[NSString stringWithFormat:@"%@",[uid valueForKey:@"date"]] isEqualToString:[NSString stringWithFormat:@"%@",[uidToDelete valueForKey:@"date"]]]){
                [app cancelLocalNotification:oneEvent];
                break;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteNotification:indexPath];
    NSManagedObjectContext *context = self.managedObjectContext;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.reminders objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove Medicine from table view
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [self.selectedMedicines addObject:[self.reminders objectAtIndex:indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    [self.selectedMedicines removeObject:[self.reminders objectAtIndex:indexPath.row]];
}

- (void)calculateTripPlanningMedicineQuantity{
    if (![self.quantityTextField.text isEqualToString:@""]) {
        self.resultOfMedicineQuantities = [@[] mutableCopy];
        for (int arrayCount = 0; [self.selectedMedicines count]>arrayCount; arrayCount++) {
            [self.resultOfMedicineQuantities addObject:[NSNumber numberWithInt:[self.quantityTextField.text intValue]]];
        }
    }
    [self.tableView reloadData];
}
- (void)alertView:(UIAlertView *)actionSheet {
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    [self calculateTripPlanningMedicineQuantity];
    if ([self.selectedReminders count] == 0 || !self.selectedReminders) {
        UIAlertView *theAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Erro no Planejamento"
                                 message:@"Para fazer um planejamento de viagens, selecione algum remédio."
                                 delegate:self
                                 cancelButtonTitle:@"Voltar ao Planejamento"
                                 otherButtonTitles:nil];
        [theAlert show];
        [self alertView:theAlert];
        return NO;
    }else if ([self.quantityTextField.text intValue]<= 0){
        UIAlertView *theAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Erro no Planejamento"
                                 message:@"Para fazer um planejamento de viagens, insira a quantidade de dias em que estará viajando."
                                 delegate:self
                                 cancelButtonTitle:@"Voltar ao Planejamento"
                                 otherButtonTitles:nil];
        [theAlert show];
        [self alertView:theAlert];
        return NO;
    }else{
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"resultsSegue"]) {
        SPTripPlanningResultsViewController * tripPlanningResultsVC = segue.destinationViewController;
        tripPlanningResultsVC.selectedReminders = self.selectedReminders;
        tripPlanningResultsVC.resultOfMedicineQuantities = self.resultOfMedicineQuantities;
        tripPlanningResultsVC.numberOfTripDays = [NSNumber numberWithInt:[self.quantityTextField.text intValue]];
    }
}

@end
