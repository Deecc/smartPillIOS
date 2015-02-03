//
//  SPBoxViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPBoxViewController.h"
#import "SPAppDelegate.h"
#import "SPViewController.h"
#import "SPTabBarViewController.h"
#import "SPMedicineDetailsViewController.h"
#import "SPNewMedicineViewController.h"

@interface SPBoxViewController ()

@property (strong,nonatomic) NSMutableArray *medicines;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SPBoxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)deleteNotification:(NSIndexPath *)indexPath{
    
    Medicine * medicine = [self.medicines objectAtIndex:indexPath.row];

    //Delete notification
    NSDictionary * uidToDelete = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat: @"%@",medicine.name ], @"medicineName", nil];
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary * uid = oneEvent.userInfo;
        if ([[uid valueForKey:@"medicineName"] isEqual:[uidToDelete valueForKey:@"medicineName"]])
        {
            [app cancelLocalNotification:oneEvent];
        }
    }
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
    NSManagedObject *medicine = [self.medicines objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [medicine valueForKey:@"name"], [medicine valueForKey:@"quantity"]]];
    [cell.detailTextLabel setText:[medicine valueForKey:@"manufacturer"]];
    
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
    }else if ([[segue identifier] isEqualToString:@"newmedicine2"]) {
        SPNewMedicineViewController * newMedicineVC = segue.destinationViewController;
        newMedicineVC.currentUser = [self getCurrentDatabaseUser];
    }    
}
@end
