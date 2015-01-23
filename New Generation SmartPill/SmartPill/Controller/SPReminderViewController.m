//
//  SPReminderViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPReminderViewController.h"
#import "SPAppDelegate.h"
#import "SPUserHandler.h"
#import "User.h"
#import "Medicine.h"
#import "Reminder.h"
#import "SPNewReminderViewController.h"
#import "SPReminderDetailsViewController.h"

@interface SPReminderViewController ()

@property (strong,nonatomic) NSMutableArray * medicines;
@property (strong,nonatomic) NSMutableArray * reminders;

@end

@implementation SPReminderViewController

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


- (NSMutableArray *)reminders
{
    _reminders = [@[] mutableCopy];
    for (Medicine * med in self.medicines) {
        [_reminders addObject:med.reminder];
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
    NSManagedObject *reminder = [self.reminders objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [reminder valueForKey:@"reminder_schedule"]]];
    [cell.detailTextLabel setText:[[reminder valueForKey:@"medicine"]valueForKey:@"name"]];
    
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
    [self performSegueWithIdentifier:@"reminderDetailsSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"reminderDetailsSegue"]) {
        Reminder * selectedReminder = [self.reminders objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        SPReminderDetailsViewController * reminderDetailsVC = segue.destinationViewController;
        reminderDetailsVC.reminder = selectedReminder;
    }else if ([[segue identifier] isEqualToString:@"newReminder"]) {
        //SPNewReminderViewController * newReminderVC = segue.destinationViewController;
    }
}

@end
