//
//  SPViewController.m
//  SmartPill
//
//  Created on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPViewController.h"
#import "SPScheduleViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "SPLoginLines.h"
#import "SPTabBarViewController.h"
#import "SPNewUserViewController.h"



static NSString * const kClientId = @"912018405938-atbar4rkaaot5e984v5prcm9m0pck53j.apps.googleusercontent.com";

@interface SPViewController ()

@end

@implementation SPViewController {
    GPPSignIn *signIn;
}

//Inicializando a aplicação, desenhando 2 botões personalizados.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UITabBar appearance] setTintColor:[UIColor greenColor]];
    [self createViews];
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
            [SPUserHandler sendUserToRemoteDatabase:    facebookUser];
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

#pragma mark - Google+

//Método para criar o botão do Google+.
-(void)createGoogleLoginButton {
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserID = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    
    
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    GPPSignInButton *loginGoogleView = [[GPPSignInButton alloc] init];
    loginGoogleView.frame = CGRectMake(170, 100, 130, 47);
    
    
    UIImage *loginImage = [UIImage imageNamed:@"Google+.png"];
    UIImage *loginImageHighlithed = [UIImage imageNamed:@"Google+.png"];
    
    [loginGoogleView setBackgroundImage:loginImage forState:UIControlStateNormal];
    [loginGoogleView setBackgroundImage:nil forState:UIControlStateSelected];
    [loginGoogleView setBackgroundImage:loginImageHighlithed forState:UIControlStateHighlighted];
    [loginGoogleView sizeToFit];
    
    [self.view addSubview:loginGoogleView];
    
}

//Método chamado quando o login funciona.
- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {
    
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
        
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
        
        // 1. Create a |GTLServicePlus| instance to send a request to Google+.
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
        plusService.retryEnabled = YES;
        
        // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
        [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
        
        // 3. Use the "v1" version of the Google+ API.*
        plusService.apiVersion = @"v1";
        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error) {
                        //Handle Error
                    } else {
                        self.googleUserId = person.identifier;
                        self.googleUserName = person.displayName;
                        for (GTLPlusPersonEmailsItem *email in person.emails) {
                            if ([email isKindOfClass: [GTLPlusPersonEmailsItem class]]) {
                                self.googleUserEmail = email.value;
                            }
                        }
                        SPUser* googleUser = [SPUserHandler createUserWithName:self.googleUserName Email:self.googleUserEmail UserId:self.googleUserId andPassword:nil];
                        if ([SPUserHandler doesUserExist:googleUser]) {
                            [SPUserHandler updateUserDataFromServer:googleUser];
                            [self goToHomeScreen];
                        }else{
                            [SPUserHandler sendUserToLocalDatabase:googleUser];
                            [SPUserHandler sendUserToRemoteDatabase:googleUser];
                        }
                    }
                }];
    }
}

//Método usado para conferencia de dados.
- (void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        // Perform other actions here, such as showing a sign-out button
      
//        if([signIn.userID isEqualToString:@"107336804221157967523"]){
//            [self goToHomeScreen];
//        }else{NSLog(@"Usuário não autorizado");}
//    }else{
//        UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 100, 100)];
//        loginLabel.text = @"You're not logged in GOOGLE+!";
//        loginLabel.textAlignment = NSTextAlignmentCenter;
//        [loginLabel sizeToFit];
//        [self.view addSubview:loginLabel];
    }
}

#pragma mark - Extra views

- (void)createLineViews{
    SPLoginLines *lines = [[SPLoginLines alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:lines];
}
- (void)createLabelSignIn{
    CGRect labelRectLogin = CGRectMake(116, 70, 85, 28);
    UILabel *labelLogin = [[UILabel alloc] initWithFrame:labelRectLogin];
    labelLogin.text = @"ENTRAR COM";
    [labelLogin setFont: [UIFont fontWithName:@"Arial" size:12.0]];
    [labelLogin setTextColor:[UIColor grayColor]];
    [self.view addSubview:labelLogin];
}
- (void)createLabelOr{
    CGRect labelRectOr = CGRectMake(152, 150, 26, 30);
    UILabel *labelOr = [[UILabel alloc] initWithFrame:labelRectOr];
    labelOr.text = @"OU";
    [labelOr setFont: [UIFont fontWithName:@"Arial" size:12.0]];
    [labelOr setTextColor:[UIColor grayColor]];
    [self.view addSubview:labelOr];
}

- (void)createLabelInsertEmail{
    CGRect labelRectEmail = CGRectMake(20, 190, 200, 28);
    UILabel *labelEmail = [[UILabel alloc] initWithFrame:labelRectEmail];
    labelEmail.text = @"Insira seu email aqui:";
    [labelEmail setFont: [UIFont systemFontOfSize:15]];
    [self.view addSubview:labelEmail];
}

- (void)createLabelInsertPassword{
    CGRect labelRectPassword = CGRectMake(20, 260, 200, 28);
    UILabel *labelPassword = [[UILabel alloc] initWithFrame:labelRectPassword];
    labelPassword.text = @"Insira sua senha aqui:";
    [labelPassword setFont: [UIFont systemFontOfSize:15]];
    [self.view addSubview:labelPassword];
}

- (void)createEmailTextField{
    CGRect textFieldRectEmail = CGRectMake(20, 220, 280, 40);
    UITextField * emailTextField = [[UITextField alloc] initWithFrame:textFieldRectEmail];
    emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    emailTextField.font = [UIFont systemFontOfSize:15];
    emailTextField.placeholder = @"Email";
    emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailTextField.keyboardType = UIKeyboardTypeDefault;
    emailTextField.returnKeyType = UIReturnKeyDone;
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailTextField.delegate = self;
    [self.view addSubview:emailTextField];
}

- (void)createPasswordTextField{
    CGRect textFieldRectPassword = CGRectMake(20, 290, 280, 40);
    UITextField * passwordTextField = [[UITextField alloc] initWithFrame:textFieldRectPassword];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.placeholder = @"Senha";
    passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.delegate = self;
    [self.view addSubview:passwordTextField];
}

- (void)createSignInButton{
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signInButton addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    [signInButton setTitle:@"Entrar" forState:UIControlStateNormal];
    signInButton.titleLabel.font = [UIFont systemFontOfSize:23];
    signInButton.frame = CGRectMake(120,330,80,60);
    [self.view addSubview:signInButton];
}

- (void)createNewUserButton{
    UIButton *newUserButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [newUserButton addTarget:self
                     action:@selector(goToSignUpScreen)
           forControlEvents:UIControlEventTouchUpInside];
    [newUserButton setTitle:@"Sem Cadastro?" forState:UIControlStateNormal];
    newUserButton.titleLabel.font = [UIFont systemFontOfSize:15];
    newUserButton.frame = CGRectMake(20,527,110,40);
    [self.view addSubview:newUserButton];
}

- (void)createForgotPasswordButton{
    UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [forgotPasswordButton addTarget:self
                      action:@selector(aMethod:)
            forControlEvents:UIControlEventTouchUpInside];
    [forgotPasswordButton setTitle:@"Esqueceu a senha?" forState:UIControlStateNormal];
    forgotPasswordButton.titleLabel.font = [UIFont systemFontOfSize:15];
    forgotPasswordButton.frame = CGRectMake(170,527,140,40);
    [self.view addSubview:forgotPasswordButton];
}

- (void)createButtonViews{
    [self createFacebookLoginButton];
    [self createGoogleLoginButton];
    [self createSignInButton];
    [self createNewUserButton];
    [self createForgotPasswordButton];
}

- (void)createLabelViews{
    [self createLabelSignIn];
    [self createLabelOr];
    [self createLabelInsertEmail];
    [self createLabelInsertPassword];
}

- (void)createTextFieldViews{
    [self createEmailTextField];
    [self createPasswordTextField];
}

- (void)setNavegationBarConfigs{
    self.navigationController.navigationBar.topItem.title = @"SmartPill";
}

- (void)createViews{
    [self createLineViews];
    [self createButtonViews];
    [self createLabelViews];
    [self createTextFieldViews];
    [self setNavegationBarConfigs];
}
#pragma mark - Extra

- (void)passingDataToTabBar:(SPTabBarViewController*)tbvc{
    if (self.facebookUserName) {
        tbvc.facebookUserName = self.facebookUserName;
        tbvc.facebookUserId = self.facebookUserId;
        tbvc.facebookUserEmail = self.facebookUserEmail;
    }
    if (self.googleUserName) {
        tbvc.googleUserName = self.googleUserName;
        tbvc.googleUserId = self.googleUserId;
        tbvc.googleUserEmail = self.googleUserEmail;
    }
}

#pragma mark - Exchanging screens

//Método que muda para a instancia do controlador ScheduleViewController e cria sua view.
- (void)goToHomeScreen{
    if ([self isEqual:self.navigationController.topViewController]) {
        SPTabBarViewController * viewControllerTabBar = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
        [self passingDataToTabBar:viewControllerTabBar];
    //passando dados para a tabBar
        viewControllerTabBar.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:viewControllerTabBar animated:YES];
    }
}

- (void)goToSignUpScreen{
    [self performSegueWithIdentifier:@"newUserSegue" sender:self];
}

@end