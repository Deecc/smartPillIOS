//
//  SPMedicineDetailsViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPMedicineDetailsViewController.h"
#import "SPNewMedicineViewController.h"

@interface SPMedicineDetailsViewController ()

@end

@implementation SPMedicineDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self writingLabels];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)BackToLastViewAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"newmedicine3"]) {
        SPNewMedicineViewController * newMedicineVC = segue.destinationViewController;
        newMedicineVC.currentUser = [self getCurrentDatabaseUser];
        newMedicineVC.medicine = self.medicine;
    }
}

- (void)writingLabels{
    if (self.medicine) {
        [self.nameLabel setText:[self.medicine valueForKey:@"name"]];
        [self.quantityLabel setText:[NSString stringWithFormat:@"%@",[self.medicine valueForKey:@"quantity"]]];
        [self.madeInLabel setText:[self.medicine valueForKey:@"manufacturer"]];
    }
}

- (Medicine*)medicine{
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    if (tbvc.medicine) {
        _medicine = tbvc.medicine;
    }
    return _medicine;
}
@end
