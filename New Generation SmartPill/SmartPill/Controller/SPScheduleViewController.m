//
//  SPScheduleViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//


#import "SPScheduleViewController.h"
#import "SPUserHandler.h"
#import "SPTabBarViewController.h"
#import "SPAppDelegate.h"
#import "SPNewMedicineViewController.h"


@interface SPScheduleViewController ()

@end

@implementation SPScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    SPAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    if (delegate.managedObjectContext) {
        context = delegate.managedObjectContext;
    }
    return context;
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
    if ([[segue identifier] isEqualToString:@"newmedicine"]) {
        SPNewMedicineViewController * newMedicineVC = segue.destinationViewController;
        newMedicineVC.currentUser = [self getCurrentDatabaseUser];
    }
}
@end
