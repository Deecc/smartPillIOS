//
//  SPProfileViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 27/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPProfileViewController.h"
#import "SPViewController.h"
#import "SPTabBarViewController.h"

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
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    if (tbvc.facebookUserName) {
        return tbvc.facebookUserName;
    }
    if (tbvc.googleUserName) {
        return tbvc.googleUserName;
    }
    return nil;
}

- (NSString*)userEmailString{
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    if (tbvc.facebookUserName) {
        return tbvc.facebookUserEmail;
    }
    if (tbvc.googleUserName) {
        return tbvc.googleUserEmail;
    }
    return nil;
}

- (NSString*)connectedWithString{
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    if (tbvc.facebookUserName) {
        return @"Facebook";
    }
    if (tbvc.googleUserName) {
        return @"Google";
    }
    return nil;
}

- (IBAction)removeAccountAction:(UIButton *)sender {
    //Retirar do banco
}

@end
