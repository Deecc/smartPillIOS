//
//  SPMedicineDetailsViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPMedicineDetailsViewController.h"

@interface SPMedicineDetailsViewController ()

@end

@implementation SPMedicineDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self writingLabels];
}


- (IBAction)BackToLastViewAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (Medicine*)tabBarMedicine{
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    if (tbvc.medicine) {
        return tbvc.medicine;
    }
    return nil;
}
@end
