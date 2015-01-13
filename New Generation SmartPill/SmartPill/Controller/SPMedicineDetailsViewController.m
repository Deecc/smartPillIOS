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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.medicine) {
        [self.nameLabel setText:[self.medicine valueForKey:@"nome"]];
        [self.quantityLabel setText:[self.medicine valueForKey:@"quantidade"]];
        [self.madeInLabel setText:[self.medicine valueForKey:@"fabricante"]];
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

@end
