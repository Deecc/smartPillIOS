//
//  SPReminderViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//
#import "SPReminderViewController.h"

@interface SPReminderViewController ()
@property (nonatomic)  NSMutableArray * novoArrayEtals;
@end

@implementation SPReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
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
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
    
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
    NSManagedObjectContext *context = self.managedObjectContext;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [self deleteNotificationFromReminderIn:indexPath];
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
        SPNewReminderViewController * newReminderVC = segue.destinationViewController;
        newReminderVC.reminder = nil;
    }
}



@end
