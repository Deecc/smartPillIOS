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
#import "SPAppDelegate.h"

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

- (NSString*)userIdNumber{
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    if (tbvc.facebookUserId) {
        return tbvc.facebookUserId;
    }
    if (tbvc.googleUserId) {
        return tbvc.googleUserId;
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

- (void)resetUserLabelData{
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
    tbvc.facebookUserName = nil;
    tbvc.facebookUserId = nil;
    tbvc.facebookUserEmail = nil;
    tbvc.googleUserName = nil;
    tbvc.googleUserId = nil;
    tbvc.googleUserEmail = nil;
}

- (IBAction)removeAccountAction:(UIButton *)sender {
    //Retirar do banco
    SPAppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    if ([[self connectedWithString]isEqualToString:@"Facebook"]) {
        SPUser * user = [SPUserHandler createFacebookUserWithName:[self userNameString] Email:[self userEmailString] UserFacebookId:[self userIdNumber]];
        [SPUserHandler deleteUser:user fromDataBase:appDelegate.managedObjectContext];
        [self resetUserLabelData];
        [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
    }else if ([[self connectedWithString]isEqualToString:@"Google"]){
        SPUser * user = [SPUserHandler createGoogleUserWithName:[self userNameString] Email:[self userEmailString] UserGoogleId:[self userIdNumber]];
        [SPUserHandler deleteUser:user fromDataBase:appDelegate.managedObjectContext];
        [self resetUserLabelData];
        [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
