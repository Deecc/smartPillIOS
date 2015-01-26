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

@end

@implementation SPNewReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.reminder) {
        [self addingPlaceHolders];
    }
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

- (IBAction)doneButtonAction:(UIBarButtonItem *)sender {
    //    if (self.reminder) {
    //        // Update existing medicine
    //        [self addingName];
    //        [self addingActiveIngredient];
    //        [self addingManufacturer];
    //        [self addingAvailability];
    //        [self addingQuantity];
    //        [Medicine updateMedicine:self.medicine fromDataBaseContext:[self managedObjectContext]];
    //    } else {
    //        // Create a new medicine
    //        Medicine * medicine = [Medicine medicineWithName:self.nameTextField.text availability:self.presentationTextField.text  manufactuary:self.madeInTextField.text activeIngredient:self.activePrincipleTextField.text quantity:[NSNumber numberWithInt:[self.quantityTextField.text intValue]] reminder:nil user:self.currentUser inManagedObjectContext:[self managedObjectContext]];
    //        self.medicine = medicine;
    //    }
    //    NSError *error = nil;
    //    // Save the object to persistent store
    //    if (![[self managedObjectContext] save:&error]) {
    //        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    //    }
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addingPlaceHolders{
    //    self.nameTextField.placeholder = self.medicine.name;
    //    self.activePrincipleTextField.placeholder = self.medicine.activeIngredient;
    //    self.madeInTextField.placeholder = self.medicine.manufacturer;
    //    self.presentationTextField.placeholder = self.medicine.availability;
    //    self.quantityTextField.placeholder = [NSString stringWithFormat:@"%@",self.medicine.quantity];
}

#pragma mark - AddingDataToMedicines

- (void)addingName{
    //    if ([self.nameTextField.text isEqualToString:@""]) {
    //        [self.medicine setValue:self.nameTextField.placeholder forKey:@"name"];
    //    }else{
    //        [self.medicine setValue:self.nameTextField.text forKey:@"name"];
    //    }
}
- (void)addingActiveIngredient{
    //    if ([self.activePrincipleTextField.text isEqualToString:@""]) {
    //        [self.medicine setValue:self.activePrincipleTextField.placeholder forKey:@"activeIngredient"];
    //    }else{
    //        [self.medicine setValue:self.activePrincipleTextField.text forKey:@"activeIngredient"];
    //    }
}
- (void)addingManufacturer{
    //    if ([self.madeInTextField.text isEqualToString:@""]) {
    //        [self.medicine setValue:self.madeInTextField.placeholder forKey:@"manufacturer"];
    //    }else{
    //        [self.medicine setValue:self.madeInTextField.text forKey:@"manufacturer"];
    //    }
}
- (void)addingAvailability{
    //    if ([self.presentationTextField.text isEqualToString:@""]) {
    //        [self.medicine setValue:self.presentationTextField.placeholder forKey:@"availability"];
    //    }else{
    //        [self.medicine setValue:self.presentationTextField.text forKey:@"availability"];
    //    }
}
- (void)addingQuantity{
    //    if ([self.quantityTextField.text isEqualToString:@""]) {
    //        [self.medicine setValue:[NSNumber numberWithInt:[self.quantityTextField.placeholder intValue]] forKey:@"quantity"];
    //    }else{
    //        [self.medicine setValue:[NSNumber numberWithInt:[self.quantityTextField.text intValue]] forKey:@"quantity"];
    //    }
}
- (void)sendReminderToReminderDetailsView{
    SPTabBarViewController * tbvc = (SPTabBarViewController*)self.tabBarController;
    tbvc.reminder = self.reminder;
}

@end

