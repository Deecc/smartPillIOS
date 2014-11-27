//
//  SPViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//
#import <FacebookSDK/FacebookSDK.h>
#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import "SPUserHandler.h"

@class GPPSignInButton;

@interface SPViewController : UIViewController<FBLoginViewDelegate,GPPSignInDelegate>

//Google
@property NSString * googleUserId;
@property NSString * googleUserName;
@property NSString * googleUserEmail;
//Facebook
@property NSString * facebookUserId;
@property NSString * facebookUserName;
@property NSString * facebookUserEmail;

@end
