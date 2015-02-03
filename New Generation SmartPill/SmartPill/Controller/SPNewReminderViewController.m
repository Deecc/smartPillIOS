//
//  SPNewReminderViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 21/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPNewReminderViewController.h"
#import "SPTabBarViewController.h"


@interface SPNewReminderViewController ()

@property (nonatomic)  NSString * selectedMedicine;
@property (nonatomic)  Medicine * currentSelectedMedicine;

@end

@implementation SPNewReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.medicinePicker.dataSource = self;
    self.medicinePicker.delegate = self;
    self.datePicker.datePickerMode = UIDatePickerModeTime;
}

- (Medicine *)currentSelectedMedicine{
    NSInteger row;
    row = [self.medicinePicker selectedRowInComponent:0];
    NSString* name = [self.medicineNamePicker objectAtIndex:row];
    
    return [self getMedicineWithName:name];
}

- (NSString*)selectedMedicine{
    return [[self currentSelectedMedicine]name];
}

- (NSMutableArray *)medicineNamePicker{
    if (!_medicineNamePicker) {
        NSMutableArray * pickerList = [@[] mutableCopy];
        for (Medicine * med in self.medicines) {
            [pickerList addObject:med.name];
        }
        _medicineNamePicker = pickerList;
    }
    return _medicineNamePicker;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.medicineNamePicker.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.medicineNamePicker[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedMedicine = [self.medicineNamePicker objectAtIndex:row];
}

- (NSMutableArray *)medicines
{
    User * user = [SPUserHandler getCurrentDatabaseUser];
    _medicines = [[user.medicine allObjects]mutableCopy];
    return _medicines;
}

- (Medicine*)getMedicineWithName:(NSString*)medicineName{
    for (Medicine * med in self.medicines) {
        if ([med.name isEqualToString:medicineName]) {
            return med;
        }
    }
    return nil;
}

- (Medicine*)getMedicineWithDate:(NSDate*)date{
    
    for (Medicine* med in self.medicines) {
        for (Reminder* rem in med.reminder) {
            if ([rem.reminder_schedule.schedule isEqual:date]) {
                return med;
            }
        }
    }
    return nil;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (Reminder_Schedule*)createReminderSchedule{
    Reminder_Schedule * schedule = [Reminder_Schedule reminderScheduleOfReminder:nil withDate:self.datePicker.date inManagedObjectContext:[self managedObjectContext]];
    return schedule;
}

- (IBAction)doneButtonAction:(UIBarButtonItem *)sender {
        if (self.reminder) {
            // Update existing reminder
            Reminder * oldReminder = self.reminder;
            if (self.datePicker.date) {
                self.reminder.reminder_schedule.schedule = self.datePicker.date;
            }
            if ([self getMedicineWithName: self.selectedMedicine]) {
                self.reminder.medicine = [self getMedicineWithName: self.selectedMedicine];
            }
            [Reminder updateOldReminder:oldReminder toNewReminder:self.reminder fromDataBaseContext:[self managedObjectContext]];
        } else {
            // Create a new reminder
            Reminder * reminder = [Reminder reminderOfMedicine:[self getMedicineWithName: self.selectedMedicine]
        withReminderSchedule:[self createReminderSchedule]
        reminderSound:nil inManagedObjectContext:[self managedObjectContext]];
            self.reminder = reminder;
        }
        NSError *error = nil;
        // Save the object to persistent store
        if (![[self managedObjectContext] save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    [self setNotification];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendReminderToReminderDetailsView{
    SPTabBarViewController * tbvc = (SPTabBarViewController*)self.tabBarController;
    tbvc.reminder = self.reminder;
}
#pragma mark Notification

- (void)setNotification{
    NSDictionary * userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat: @"%@",[[self currentSelectedMedicine] name]], @"medicineName", [NSString stringWithFormat: @"%@",self.datePicker.date], @"date", nil];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = self.datePicker.date;
    localNotification.alertBody = [NSString stringWithFormat:@"Hora do Remédio %@",[[self currentSelectedMedicine] name]];
    localNotification.userInfo = userinfo;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.repeatInterval = NSDayCalendarUnit;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end

