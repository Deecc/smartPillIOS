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
#import <GooglePlus/GooglePlus.h>


static NSString * const kClientId = @"912018405938-atbar4rkaaot5e984v5prcm9m0pck53j.apps.googleusercontent.com";

@interface SPViewController ()

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createLoginButton];
    [self createGoogleLoginButton];
}

#pragma mark - Facebook

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

#pragma mark - Google+
- (void)createGoogleLoginButton {
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    GPPSignInButton *loginGoogleView = [[GPPSignInButton alloc] init];
    loginGoogleView.frame = CGRectMake(200, 100, 200, 200);
    
    
    UIImage *loginImage = [UIImage imageNamed:@"google+.png"];
    UIImage *loginImageHighlithed = [UIImage imageNamed:@"google+.png"];
    
    [loginGoogleView setBackgroundImage:loginImage forState:UIControlStateNormal];
    [loginGoogleView setBackgroundImage:nil forState:UIControlStateSelected];
    [loginGoogleView setBackgroundImage:loginImageHighlithed forState:UIControlStateHighlighted];
    [loginGoogleView sizeToFit];
    
    
    [self.view addSubview:loginGoogleView];
    
}
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}



@end
