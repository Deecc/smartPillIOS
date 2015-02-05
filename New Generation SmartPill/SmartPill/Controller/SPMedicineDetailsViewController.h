//
//  SPMedicineDetailsViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataViewController.h"
#import "SPNewMedicineViewController.h"

@interface SPMedicineDetailsViewController : SPCoreDataViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *madeInLabel;
- (IBAction)BackToLastViewAction:(UIBarButtonItem *)sender;

@end
