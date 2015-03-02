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


- (void)deleteNotificationFromReminderIn:(NSIndexPath *)indexPath{
    
    Reminder * reminder = [self.reminders objectAtIndex:indexPath.row];
    Medicine * medicine = reminder.medicine;
    Reminder_Schedule * schedule = reminder.reminder_schedule;
    
    //Delete notification
    NSDictionary * uidToDelete = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat: @"%@",medicine.name ], @"medicineName", schedule.schedule, @"date", nil];
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary * uid = oneEvent.userInfo;
        if ([[uid valueForKey:@"medicineName"] isEqual:[uidToDelete valueForKey:@"medicineName"]])
        {
            if ([[NSString stringWithFormat:@"%@",[uid valueForKey:@"date"]] isEqualToString:[NSString stringWithFormat:@"%@",[uidToDelete valueForKey:@"date"]]]){
                [app cancelLocalNotification:oneEvent];
                break;
            }
        }
    }
}

- (void)deleteAllNotificationFromMedicineOf:(NSIndexPath *)indexPath{
    
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


@end
