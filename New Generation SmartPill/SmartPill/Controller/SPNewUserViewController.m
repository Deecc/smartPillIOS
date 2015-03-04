//
//  SPNewUserViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 25/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPNewUserViewController.h"

@interface SPNewUserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordConfirmation;

@end

@implementation SPNewUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)doneSignUpAction:(UIBarButtonItem *)sender {
    NSString * userName = self.userName.text;
    NSString * userEmail = self.userEmail.text;
    NSString * userPassword = self.userPassword.text;
    NSString * userPasswordConfirmation = self.userPasswordConfirmation.text;
    SPAppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    
    if ([userPassword isEqualToString:userPasswordConfirmation]) {
        SPUser * smartPillUser = [SPUserHandler createUserWithName:userName Email:userEmail UserId:nil andPassword:userPassword];
        BOOL doesUserExistOnCoreData = [SPUserHandler checkUserPresenceLocally:smartPillUser OnDataBase:appDelegate.managedObjectContext];
        BOOL doesUserExistOnServer = [SPUserHandler checkUserPresenceRemotely:smartPillUser];
        if (doesUserExistOnCoreData && doesUserExistOnServer) {
            [SPUserHandler updateUserDataFromServer:smartPillUser];
        }else if (doesUserExistOnCoreData){
            [SPUserHandler sendUserToRemoteDatabase:smartPillUser];
        }else if (doesUserExistOnServer){
            [SPUserHandler sendUser:smartPillUser toLocalDatabase:appDelegate.managedObjectContext];
        }else{
            [SPUserHandler sendUser:smartPillUser toLocalDatabase:appDelegate.managedObjectContext];
            [SPUserHandler sendUserToRemoteDatabase:smartPillUser];
        }
        [self goToSignInScreen];
    }else{
        NSLog(@"Password did not match password confirmation");
    }
}

- (IBAction)cancelSignUpAction:(UIBarButtonItem *)sender {
    [self goToSignInScreen];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goToSignInScreen{
[self dismissViewControllerAnimated:YES completion:nil];
}

@end
