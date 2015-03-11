//
//  SPFirstScreenViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPFirstScreenViewController.h"

@interface SPFirstScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@end

@implementation SPFirstScreenViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setButtonsName];
}

- (User*)getLastUser{
    return [SPUserHandler getOneUserFromDatabase];
}

- (void)storingCurrentUserInfo{
    SPUser * user = nil;
    User * userDatabase = [self getLastUser];
    SPAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    if (userDatabase.facebook.idFacebook) {
        user = [SPUserHandler createFacebookUserWithName:userDatabase.name
                                                   Email:userDatabase.email
                                          UserFacebookId:userDatabase.facebook.idFacebook];
    }else if (userDatabase.google.idGoogle){
        user = [SPUserHandler createGoogleUserWithName:userDatabase.name Email:userDatabase.email UserGoogleId:userDatabase.google.idGoogle];
    }else{
        user = [SPUserHandler createUserWithName:userDatabase.name Email:userDatabase.email UserId:userDatabase.idUser andPassword:userDatabase.password];
    }
    delegate.currentUser = user;
}

- (IBAction)goToLastUserScheduleScreen:(id)sender {
    if ([self getLastUser]) {
        SPTabBarViewController * viewControllerTabBar = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
        [self storingCurrentUserInfo];
        viewControllerTabBar.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:viewControllerTabBar animated:YES];
    }
}

- (void)setButtonsName{
    User * user = [self getLastUser];
    if (user) {
        [self.blackButton setTitle:user.name forState:UIControlStateNormal];
    }else{
        [self.blackButton setTitle:@"" forState:UIControlStateNormal];
        [self.greenButton setTitle:@"Entrar/Inscrever-se" forState:UIControlStateNormal];
    }
}
@end
