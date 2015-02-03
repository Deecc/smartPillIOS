#import "SPScheduleViewController.h"
#import "SPUserHandler.h"
#import "SPTabBarViewController.h"
#import "SPAppDelegate.h"
#import "SPNewMedicineViewController.h"
#import "SPMedicineDetailsViewController.h"
#import "Reminder+create.h"


@interface SPScheduleViewController ()
@property (strong,nonatomic) NSMutableArray *medicines;
@property (strong,nonatomic) NSMutableArray *reminders;
@property (strong,nonatomic) NSMutableArray *pastReminders;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SPScheduleViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self decreaseNumberOfBadges];
}

- (void)decreaseNumberOfBadges{
    NSInteger numberOfBadges = [UIApplication sharedApplication].applicationIconBadgeNumber;
    numberOfBadges -=1;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:numberOfBadges];
}

#pragma mark - Table view data source

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    SPAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    if (delegate.managedObjectContext) {
        context = delegate.managedObjectContext;
    }
    return context;
}

- (NSMutableArray *)medicines
{
    User * user = [self getCurrentDatabaseUser];
    _medicines = [[user.medicine allObjects]mutableCopy];
    return _medicines;
}

- (NSMutableArray *)pastReminders
{
    _pastReminders = [@[] mutableCopy];
    for (Medicine * med in self.medicines) {
        for (Reminder * rem in med.reminder) {
            if ([self hasTimeNowPassed:[self acessingStringDateFromReminder:rem]]) {
                [_pastReminders addObject:rem];
            }
        }
    }
    
    NSMutableArray *sortedArray;
    sortedArray = [_pastReminders sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [self acessingStringDateFromReminder:a];
        NSString *second = [self acessingStringDateFromReminder:b];
        return [first compare:second];
    }];
    
    return sortedArray;
}

- (NSMutableArray *)reminders
{
    _reminders = [@[] mutableCopy];
    for (Medicine * med in self.medicines) {
        for (Reminder * rem in med.reminder) {
            if (![self hasTimeNowPassed:[self acessingStringDateFromReminder:rem]]) {
                [_reminders addObject:rem];
            }
        }
    }
    
    NSMutableArray *sortedArray;
    sortedArray = [_reminders sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [self acessingStringDateFromReminder:a];
        NSString *second = [self acessingStringDateFromReminder:b];
        return [first compare:second];
    }];
    
    return sortedArray;
}
- (NSString*)acessingStringDateFromTimeNow{
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
    sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSString* a, NSString* b) {
        return [a compare:b];
    }];
    if ([[sortedArray firstObject] isEqualToString:[self acessingStringDateFromTimeNow]]) {
        return NO;
    }
    return YES;
}

- (SPUser*)getCurrentUser{
    SPAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    return delegate.currentUser;
}

- (User*)getCurrentDatabaseUser{
    SPUser * currentUser = [self getCurrentUser];
    NSArray * arrayOfDataBaseUsers = [SPUserHandler checkPresenceToReturnUserLocally:currentUser OnDataBase:[self managedObjectContext]];
    for (User *dataBaseUser in arrayOfDataBaseUsers) {
        if ([dataBaseUser.email isEqualToString:currentUser.email])
        {
            return dataBaseUser;
        }
    }
    return nil;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return [self.pastReminders count];
    }
    else{
        return [self.reminders count];
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
    Reminder *reminder = nil;
    
    if(indexPath.section==0){
        reminder = [self.pastReminders objectAtIndex:indexPath.row];
        NSDate * date = reminder.reminder_schedule.schedule;
        NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
        [timeFormat setDateFormat:@"HH:mm"];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
        [cell.detailTextLabel setText:[[reminder valueForKey:@"medicine"]valueForKey:@"name"]];
    }else{
        reminder = [self.reminders objectAtIndex:indexPath.row];
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
        if ([self.pastReminders count]>0) {
            return @"Remedios Tomados/Atrasados";
        }
        return @"";
    }else{
        if ([self.reminders count]>0) {
            return @"Remedios à Tomar";
        }
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        ///
        NSMutableArray * bothReminderArrays = [[self.pastReminders arrayByAddingObjectsFromArray:self.reminders]mutableCopy];
        Reminder *selectedReminder = [bothReminderArrays objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        [context deleteObject:selectedReminder];
        ///
        
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove Reminder from table view
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"medicineDetailsSegue2" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"medicineDetailsSegue2"]) {
        NSMutableArray * bothReminderArrays = [[self.pastReminders arrayByAddingObjectsFromArray:self.reminders]mutableCopy];
        Medicine *selectedMedicine = [[bothReminderArrays objectAtIndex:[[self.tableView indexPathForSelectedRow] row]]medicine];
        SPMedicineDetailsViewController * medicineDetailsVC = segue.destinationViewController;
        medicineDetailsVC.medicine = selectedMedicine;
    }else if ([[segue identifier] isEqualToString:@"newmedicine"]) {
        SPNewMedicineViewController * newMedicineVC = segue.destinationViewController;
        newMedicineVC.currentUser = [self getCurrentDatabaseUser];
    }
}
@end
