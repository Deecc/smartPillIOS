//
//  SPViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "SPAppDelegate.h"
#import "SPCoreDataViewController.h"
#import "SPTabBarViewController.h"

@class GPPSignInButton;

@interface SPViewController : SPCoreDataViewController<FBLoginViewDelegate,GPPSignInDelegate, UITextFieldDelegate>

//Google
@property NSString * googleUserId;
@property NSString * googleUserName;
@property NSString * googleUserEmail;
//Facebook
@property NSString * facebookUserId;
@property NSString * facebookUserName;
@property NSString * facebookUserEmail;

@end
