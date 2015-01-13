//
//  SPMoreViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 02/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPMoreViewController.h"
#import "SPTabBarViewController.h"
#import "SPViewController.h"


@interface SPMoreViewController ()
@property (weak, nonatomic) IBOutlet id signOutButton;
@property NSString* accountType;

@end

@implementation SPMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.accountType = [self checkConnectedAccount];
}

#pragma mark - Exchanging screens

//Método que muda para a instancia do controlador ScheduleViewController e cria sua view.

- (void)goToSignInScreen{
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}

- (NSString*)checkConnectedAccount{
    SPTabBarViewController* tbvc = (SPTabBarViewController*)self.tabBarController;
        if (tbvc.facebookUserName) {
            return @"Facebook";
        }
        if (tbvc.googleUserName) {
            return @"Google";
        }
            return @"SmartPill";
}
- (IBAction)signOutAction:(UIButton *)sender {
    [self resetUserLabelData];
    [self goToSignInScreen];
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

@end
