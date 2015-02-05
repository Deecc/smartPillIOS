//
//  SPCoreDataViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 04/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataViewController.h"

@interface SPCoreDataViewController ()
@end

@implementation SPCoreDataViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    SPAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (NSMutableArray *)medicines
{
    User * user = [self getCurrentDatabaseUser];
    _medicines = [[user.medicine allObjects]mutableCopy];
    return _medicines;
}
- (SPUser*)getCurrentUser
{
    SPAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    return delegate.currentUser;
}
- (User*)getCurrentDatabaseUser
{
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
- (Medicine*)getMedicineWithName:(NSString*)medicineName
{
    for (Medicine * med in self.medicines) {
        if ([med.name isEqualToString:medicineName]) {
            return med;
        }
    }
    return nil;
}
- (Medicine*)getMedicineWithDate:(NSDate*)date
{
    
    for (Medicine* med in self.medicines) {
        for (Reminder* rem in med.reminder) {
            if ([rem.reminder_schedule.schedule isEqual:date]) {
                return med;
            }
        }
    }
    return nil;
}
@end
