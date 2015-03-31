
#import "SPScheduleViewController.h"
#import "SmartPill-Swift.h"

@interface SPScheduleViewController ()
@end

@implementation SPScheduleViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self decreaseNumberOfBadges];
    [self addRemoveHelpMessage];
}

- (void)addRemoveHelpMessage{
    if ([_allRemindersOrdered count]==0) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[MyStyleKit imageOfAddHelpText]];
        [self.tableView addSubview:imgView];
    }else{
        for (UITableView *v in self.tableView.subviews) {
            if ([v isKindOfClass:[UIImageView class]]) {
                [v removeFromSuperview];
            }
        }
    }
}

- (void)decreaseNumberOfBadges{
    NSInteger numberOfBadges = [UIApplication sharedApplication].applicationIconBadgeNumber;
    numberOfBadges -=1;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:numberOfBadges];
}

#pragma mark - Table view data source
- (NSMutableArray *)allRemindersOrdered{
    _allRemindersOrdered = [@[] mutableCopy];
    for (Medicine * med in self.medicines) {
        for (Reminder * rem in med.reminder) {
            [_allRemindersOrdered addObject:rem];
        }
    }
    SPArraySorter * sorter = [[SPArraySorter alloc]init];
    _allRemindersOrdered = [sorter sortArray:_allRemindersOrdered];
    return _allRemindersOrdered;
}

- (NSMutableArray *)pastReminders
{
    _pastReminders = [@[] mutableCopy];

    for (Reminder * rem in self.allRemindersOrdered) {
        if ([self hasTimeNowPassed:[self acessingStringDateFromReminder:rem]]) {
            [_pastReminders addObject:rem];
        }
    }
    return _pastReminders;
}
//SobreEscrito da classe pai
- (NSMutableArray *)futureReminders
{
    _futureReminders = [@[] mutableCopy];
    for (Reminder * rem in self.allRemindersOrdered) {
        if (![self hasTimeNowPassed:[self acessingStringDateFromReminder:rem]]) {
            [_futureReminders addObject:rem];
        }
    }
    return _futureReminders;
}
- (NSString*)acessingStringDateFromTimeNow
{
    NSDate * date = [NSDate date];
    NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setDateFormat:@"HH:mm"];
    return [NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]];
}
- (NSString*)acessingStringDateFromReminder:(Reminder*)reminder{
    NSDate * date = reminder.reminder_schedule.schedule;
    NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setDateFormat:@"HH:mm"];
    return [NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]];
}
- (BOOL)hasTimeNowPassed:(NSString*)time{
   
    NSMutableArray *sortedArray;
    NSMutableArray *array = [@[[self acessingStringDateFromTimeNow],time]mutableCopy];
    sortedArray = [[array sortedArrayUsingComparator:^NSComparisonResult(NSString* a, NSString* b) {
        return [a compare:b];
    }]mutableCopy];
    if ([[sortedArray firstObject] isEqualToString:[self acessingStringDateFromTimeNow]]) {
        return NO;
    }
    return YES;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return [self.pastReminders count];
    }
    else{
        return [self.futureReminders count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    /////////////////////////////////////////////////////
    // create a background image for the cell:
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"cell"]];
    [cell setBackgroundView:bgView];
    [cell setIndentationWidth:0.0];
    //
    Reminder *reminder = nil;
    
    if(indexPath.section==0){
        reminder = [_pastReminders objectAtIndex:indexPath.row];
        NSDate * date = reminder.reminder_schedule.schedule;
        NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
        [timeFormat setDateFormat:@"HH:mm"];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
        [cell.detailTextLabel setText:[[reminder valueForKey:@"medicine"]valueForKey:@"name"]];
    }else{
        reminder = [_futureReminders objectAtIndex:indexPath.row];
        NSDate * date = reminder.reminder_schedule.schedule;
        NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
        [timeFormat setDateFormat:@"HH:mm"];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
        [cell.detailTextLabel setText:[[reminder valueForKey:@"medicine"]valueForKey:@"name"]];
    }
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if ([_pastReminders count]>0) {
            return @"Remedios Tomados/Atrasados";
        }else{
            return nil;
        }
    }else if(section==1){
        if ([_futureReminders count]>0) {
            return @"Remedios à Tomar";
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [self deleteNotificationFromReminderIn:indexPath];
        if ([indexPath section]==0) {
            Reminder *selectedReminder = [_pastReminders objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            [_pastReminders removeObject:selectedReminder];
            [context deleteObject:selectedReminder];
        }else{
            Reminder *selectedReminder = [_futureReminders objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            [_futureReminders removeObject:selectedReminder];
            [context deleteObject:selectedReminder];
        }
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove Reminder from table view
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    [self addRemoveHelpMessage];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"medicineDetailsSegue2" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"medicineDetailsSegue2"]) {
        if ([[self.tableView indexPathForSelectedRow] section] == 0) {
            Medicine *selectedMedicine = (Medicine*)[[_pastReminders objectAtIndex:[[self.tableView indexPathForSelectedRow] row]]medicine];
            SPMedicineDetailsViewController * medicineDetailsVC = segue.destinationViewController;
            medicineDetailsVC.medicine = selectedMedicine;
        }else{
            Medicine *selectedMedicine = (Medicine*)[[_futureReminders objectAtIndex:[[self.tableView indexPathForSelectedRow] row]]medicine];
            SPMedicineDetailsViewController * medicineDetailsVC = segue.destinationViewController;
            medicineDetailsVC.medicine = selectedMedicine;
        }
        
    }
}

- (IBAction)displayActionSheet:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Adicionar"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Remédios", @"Lembretes",
                                  @"Receitas", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}

#pragma mark UIActionSheetDelegate

- (void)goToNewMedicine{
    SPNewMedicineViewController * newMedicineVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newmedicine"];;
    newMedicineVC.currentUser = [self getCurrentDatabaseUser];
    [self presentViewController:newMedicineVC animated:YES completion:nil];
}

- (void)goToNewReminder{
    SPNewReminderViewController * newReminderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newReminderVC"];
    newReminderVC.reminder = nil;
    [self presentViewController:newReminderVC animated:YES completion:nil];
}

- (void)goToNewRecipe{
    SPAddPrescription * newRecipeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newRecipeVC"];;
    [self presentViewController:newRecipeVC animated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self goToNewMedicine];
            break;
        case 1:
            [self goToNewReminder];
            break;
        case 2:
            [self goToNewRecipe];
            break;
    }
    
}
@end
