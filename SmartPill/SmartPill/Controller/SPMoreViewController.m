//
//  SPMoreViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 02/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPMoreViewController.h"


@interface SPMoreViewController ()

@end

@implementation SPMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSignOutButton];
}

#pragma mark - Facebook

//Método para criar o botão do Facebook.
- (void)createFacebookLoginButton{
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake(20,100,130,47);
    for (id obj in loginView.subviews)
    {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *loginButton =  obj;
            UIImage *loginImage = [UIImage imageNamed:@"Facebook.png"];
            UIImage *loginImageHighlithed = [UIImage imageNamed:@"Facebook.png"];
            
            [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
            [loginButton setBackgroundImage:nil forState:UIControlStateSelected];
            [loginButton setBackgroundImage:loginImageHighlithed forState:UIControlStateHighlighted];
            [loginButton sizeToFit];
        }
        if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel *loginLabel =  obj;
            loginLabel.text = @"";
            loginLabel.textAlignment = NSTextAlignmentCenter;
            loginLabel.frame = CGRectMake(0, 0, 0, 0);
            [loginLabel sizeToFit];
        }
    }
    
    loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

//Método chamado para pegar informações do usuário.
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.facebookUserId = user.id;
    self.facebookUserName = user[@"name"];
    self.facebookUserEmail = [user objectForKey:@"email"];
    
    SPUser* facebookUser = [SPUserHandler createUserWithName:self.facebookUserName Email:self.facebookUserEmail UserId:self.facebookUserId andPassword:nil];
    
    if ([SPUserHandler doesUserExist:facebookUser]) {
        [SPUserHandler updateUserDataFromServer:facebookUser];
        [self goToHomeScreen];
    }else{
        [SPUserHandler sendUserToLocalDatabase:facebookUser];
        [SPUserHandler sendUserToRemoteDatabase:facebookUser];
    }
    
}

//Cuida de possiveis erros ao logar
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - Extra views

- (void)createSignOutButton{
    UIButton *signOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signOutButton addTarget:self
                     action:@selector(signOutFromSmartPill)
           forControlEvents:UIControlEventTouchUpInside];
    [signOutButton setTitle:@"testestestestestestestestesteste" forState:UIControlStateNormal];
    signOutButton.frame = CGRectMake(0,0,0,0);
    UIImage *signOutButtonImage = [UIImage imageNamed:@"signOut.png"];
    [signOutButton setBackgroundImage:signOutButtonImage forState:UIControlStateNormal];
    [signOutButton setBackgroundImage:nil forState:UIControlStateSelected];
    [signOutButton setBackgroundImage:signOutButtonImage forState:UIControlStateHighlighted];
    [signOutButton sizeToFit];
    [self.view addSubview:signOutButton];
}

#pragma mark - Exchanging screens

//Método que muda para a instancia do controlador ScheduleViewController e cria sua view.
- (void)goToHomeScreen{
//    SPTabBarViewController * viewControllerTabBar = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
//    [self passingDataToTabBar:viewControllerTabBar];
//    //passando dados para a tabBar
//    viewControllerTabBar.navigationItem.hidesBackButton = YES;
//    [self.navigationController pushViewController:viewControllerTabBar animated:YES];
}

- (void)goToSignUpScreen{
//    UITabBarController * viewControllerNewUser = [self.storyboard instantiateViewControllerWithIdentifier:@"newuser"];
//    viewControllerNewUser.navigationItem.hidesBackButton = YES;
//    [self.navigationController pushViewController:viewControllerNewUser animated:YES];
}

@end
