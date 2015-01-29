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
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SPScheduleViewController

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

- (NSMutableArray *)reminders
{
    _reminders = [@[] mutableCopy];
    for (Medicine * med in self.medicines) {
        for (Reminder * rem in med.reminder) {
            [_reminders addObject:rem];
        }
    }
    return _reminders;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.medicines.count;
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
    if ([self.reminders count]>0) {
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


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.medicines objectAtIndex:indexPath.row]];
        
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
    [self performSegueWithIdentifier:@"medicineDetailsSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"medicineDetailsSegue"]) {
        Medicine *selectedMedicine = [self.medicines objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        SPMedicineDetailsViewController * medicineDetailsVC = segue.destinationViewController;
        medicineDetailsVC.medicine = selectedMedicine;
    }else if ([[segue identifier] isEqualToString:@"newmedicine"]) {
        SPNewMedicineViewController * newMedicineVC = segue.destinationViewController;
        newMedicineVC.currentUser = [self getCurrentDatabaseUser];
    }
}
@end
