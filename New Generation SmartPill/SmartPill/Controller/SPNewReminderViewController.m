//
//  SPNewReminderViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 21/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPNewReminderViewController.h"
#import "SPTabBarViewController.h"
#import "Medicine+create.h"


@interface SPNewReminderViewController ()

@property NSString * selectedMedicine;

@end

@implementation SPNewReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.reminder) {
        [self addingPlaceHolders];
    }
    self.medicinePicker.dataSource = self;
    self.medicinePicker.delegate = self;
    self.datePicker.datePickerMode = UIDatePickerModeTime;
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
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addingPlaceHolders{
    //    self.nameTextField.placeholder = self.medicine.name;
    //    self.activePrincipleTextField.placeholder = self.medicine.activeIngredient;
    //    self.madeInTextField.placeholder = self.medicine.manufacturer;
    //    self.presentationTextField.placeholder = self.medicine.availability;
    //    self.quantityTextField.placeholder = [NSString stringWithFormat:@"%@",self.medicine.quantity];
}

- (void)sendReminderToReminderDetailsView{
    SPTabBarViewController * tbvc = (SPTabBarViewController*)self.tabBarController;
    tbvc.reminder = self.reminder;
}

@end

