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
    @property NSString * email;
@end

@implementation SPViewController {
 GPPSignIn *signIn ; 
}

//Inicializando a aplicação, desenhando 2 botões personalizados.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createFacebookLoginButton];
    [self createGoogleLoginButton];
}

#pragma mark - Facebook

//Método para criar o botão do Facebook.
- (void)createFacebookLoginButton{
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

//Método chamado para pegar informações do usuário.
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    if ([user.id isEqualToString:@"878485092182794"]) {
        [self goToHomeScreen];
    }
}
//Método que muda para o instancia o controlador ScheduleViewController e cria sua view.
- (void)goToHomeScreen{
    UITabBarController * viewControllerLogged = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    viewControllerLogged.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:viewControllerLogged animated:YES];
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

#pragma mark - Google+

//Método para criar o botão do Google+.
- (void)createGoogleLoginButton {
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    
    
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

//Método chamado quando o login funciona.
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        self.email = signIn.authentication.userEmail;
        [self refreshInterfaceBasedOnSignIn];
    }
}

//Método usado para conferencia de dados.
-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        // Perform other actions here, such as showing a sign-out button
        if([self.email isEqualToString:@"thiago.ericus@gmail.com"]){
            [self goToHomeScreen];
        }else{NSLog(@"Email não autorizado");}
    }else{
        UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 100, 100)];
        loginLabel.text = @"You're not logged in GOOGLE+!";
        loginLabel.textAlignment = NSTextAlignmentCenter;
        [loginLabel sizeToFit];
        [self.view addSubview:loginLabel];
    }
}

@end
