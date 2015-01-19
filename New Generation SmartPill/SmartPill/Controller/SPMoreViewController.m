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
    SPAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        if (delegate.currentUser.userFacebookId) {
            return @"Facebook";
        }
        if (delegate.currentUser.userGoogleId) {
            return @"Google";
        }
            return @"SmartPill";
}
- (IBAction)signOutAction:(UIButton *)sender {
    [self resetUserLabelData];
    [self goToSignInScreen];
}

- (void)resetUserLabelData{
    SPAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    delegate.currentUser = nil;
}

@end
