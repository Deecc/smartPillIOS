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

@interface SPBoxViewController ()

@property (strong,nonatomic) NSMutableArray *medicines;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SPBoxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
}

#pragma mark - Table view data source

- (NSManagedObjectContext *)managedObjectContext
{
    NSLog(@"managedObjectContext");
    NSManagedObjectContext *context = nil;
    SPAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    if (delegate.managedObjectContext) {
        context = delegate.managedObjectContext;
    }
    return context;
}

- (NSMutableArray *)medicines
{
    NSLog(@"medicines");
    if (!_medicines) {
        NSLog(@"IF true");
        User * user = [self getCurrentDatabaseUser];
        _medicines = [[user.medicine allObjects]mutableCopy];
        for (Medicine *med in _medicines) {
            NSLog(@"medicine name %@ quantity %@", med.name, med.quantity);
        }
        
    }
    NSLog(@"IF false");
    return _medicines;
}


- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (SPUser*)getCurrentUser{
    NSLog(@"getCurrentUser");
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    SPUser * user;
    if (tbvc.facebookUserName) {
        user = [SPUserHandler createFacebookUserWithName:tbvc.facebookUserName Email:tbvc.facebookUserEmail UserFacebookId:tbvc.facebookUserId];
    }else if (tbvc.googleUserName) {
        user = [SPUserHandler createGoogleUserWithName:tbvc.googleUserName Email:tbvc.googleUserEmail UserGoogleId:tbvc.googleUserId];
    }
    NSLog(@"User from getCurrentUser is %@",user.name);
    return user;
}

- (User*)getCurrentDatabaseUser{
    NSLog(@"getCurrentDatabaseUser");
    SPUser * currentUser = [self getCurrentUser];
    NSArray * arrayOfDataBaseUsers = [SPUserHandler checkPresenceToReturnUserLocally:currentUser OnDataBase:[self managedObjectContext]];
    for (User *dataBaseUser in arrayOfDataBaseUsers) {
        NSLog(@"arrayOfDataBaseUsers %@", dataBaseUser.name);
        if ([dataBaseUser.email isEqualToString:currentUser.email])
        {
            NSLog(@"User from getCurrentDatabaseUser is %@",dataBaseUser.name);
            return dataBaseUser;
        }
    }
    NSLog(@"getCurrentDatabaseUser returned nil");
    return nil;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
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
    NSLog(@"tableView:cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSManagedObject *medicine = [self.medicines objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [medicine valueForKey:@"nome"], [medicine valueForKey:@"quantidade"]]];
    [cell.detailTextLabel setText:[medicine valueForKey:@"fabricante"]];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:canEditRowAtIndexPath");
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:commitEditingStyle");
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.medicines objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.medicines removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    if ([[segue identifier] isEqualToString:@"medicineDetails"]) {
        Medicine *selectedMedicine = [self.medicines objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        SPMedicineDetailsViewController * medicineDetailsVC = segue.destinationViewController;
        medicineDetailsVC.medicine = selectedMedicine;
    }
}
@end
