//
//  SPBoxViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPBoxViewController.h"

@interface SPBoxViewController ()


@end

@implementation SPBoxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self addRemoveHelpMessage];
}

- (void)addRemoveHelpMessage{
    if ([self.medicines count]==0) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[MyStyleKit imageOfAddHelpMessageBox]];
        [self.tableView addSubview:imgView];
    }else{
        for (UITableView *v in self.tableView.subviews) {
            if ([v isKindOfClass:[UIImageView class]]) {
                [v removeFromSuperview];
            }
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self.medicines count]>0) {
        return @"Lista de Remédios";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    // create a background image for the cell:
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"cell"]];
    [cell setBackgroundView:bgView];
    [cell setIndentationWidth:0.0];
    //
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
        [self deleteAllNotificationFromMedicineOf:indexPath];
        [context deleteObject:[self.medicines objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove Medicine from table view
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self addRemoveHelpMessage];
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
