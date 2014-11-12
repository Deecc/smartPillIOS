//
//  SPViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPViewController.h"
#import "SPScheduleViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>



@interface SPViewController ()

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createLoginButton];
}


- (void)createLoginButton{
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake(50, 100, 200, 200);
    for (id obj in loginView.subviews)
    {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton *loginButton =  obj;
            UIImage *loginImage = [UIImage imageNamed:@"login.png"];
            UIImage *loginImageHighlithed = [UIImage imageNamed:@"login.png"];
            
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
//Método chamado para pegar informações do user
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    //self.profilePicture.profileID = user.id;
    //self.name.text = user.name;
    if ([user.id isEqualToString:@"878485092182794"]) {
        [self goToHomeScreen];
    }
}
//Método que muda para o ScheduleViewController
- (void)goToHomeScreen{
    UITabBarController * viewControllerLogged = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    viewControllerLogged.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:viewControllerLogged animated:YES];
}
//Quando da certo na hora de logar entre nesse método
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    //self.status.text = @"You're logged in as";
}
//Quando dá errado o log in
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
//    UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, 100, 100)];
//    loginLabel.text = @"You're not logged in!";
//    loginLabel.textAlignment = NSTextAlignmentCenter;
//    [loginLabel sizeToFit];
//    [self.view addSubview:loginLabel];
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
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
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



@end
