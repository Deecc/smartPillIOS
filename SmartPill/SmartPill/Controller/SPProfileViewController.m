//
//  SPProfileViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 27/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPProfileViewController.h"
#import "SPViewController.h"

@interface SPProfileViewController ()

@end

@implementation SPProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateViewConstraints];
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    self.userName.text = [self userNameString];
    self.userEmail.text = [self userEmailString];
    self.connectedWith.text = [self connectedWithString];
}

- (NSString*)userNameString{
    return @"teste";
}

- (NSString*)userEmailString{
    return @"TESTE";
}

- (NSString*)connectedWithString{
    SPViewController * firstViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"firstScreen"];
    BOOL isFacebookConnected = NO;
    BOOL google = NO;
    if (firstViewController.facebookUserName) {
        NSLog(@"%@",firstViewController.facebookUserName);
    }
    if (firstViewController.googleUserName) {
        NSLog(@"%@",firstViewController.googleUserName);
    }
    
    
    return @"teste";
}

- (IBAction)removeAccountAction:(UIButton *)sender {
}











@end
