//
//  SPNewMedicineViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPNewMedicineViewController.h"
#import "Medicine+create.h"

@interface SPNewMedicineViewController ()

@end

@implementation SPNewMedicineViewController


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
    if (self.medicine) {
        // Update existing medicine
        [self.medicine setValue:self.nameTextField forKey:@"nome"];
        [self.medicine setValue:self.activePrincipleTextField forKey:@"principioAtivo"];
        [self.medicine setValue:self.madeInTextField forKey:@"fabricante"];
        [self.medicine setValue:self.presentationTextField forKey:@"apresentacao"];
        [self.medicine setValue:self.quantityTextField forKey:@"quantidade"];
    } else {
        // Create a new medicine

        
        Medicine * medicine = [Medicine medicineWithName:self.nameTextField.text availability:self.presentationTextField.text  manufactuary:self.madeInTextField.text activeIngredient:self.activePrincipleTextField.text quantity:[NSNumber numberWithInt:[self.quantityTextField.text intValue]] reminder:nil user:self.currentUser inManagedObjectContext:[self managedObjectContext]];
        self.medicine = medicine;
        
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [SPUserHandler dataFromDatabase];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
