//
//  SPNewMedicineViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medicine.h"
#import "SPUserHandler.h"
#import "SPTabBarViewController.h"


@interface SPNewMedicineViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *activePrincipleTextField;
@property (weak, nonatomic) IBOutlet UITextField *madeInTextField;
@property (weak, nonatomic) IBOutlet UITextField *presentationTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (strong) Medicine * medicine;
@property User * currentUser;

- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender;
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender;

@end
