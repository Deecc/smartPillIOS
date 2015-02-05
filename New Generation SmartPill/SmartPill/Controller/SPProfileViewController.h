//
//  SPProfileViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 27/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//


#import "SPCoreDataViewController.h"
#import "SPTabBarViewController.h"

@interface SPProfileViewController : SPCoreDataViewController
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UILabel *connectedWith;
- (IBAction)removeAccountAction:(UIButton *)sender;

@end
