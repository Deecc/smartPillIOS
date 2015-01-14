//
//  SPTabBarViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 29/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPUserHandler.h"

@interface SPTabBarViewController : UITabBarController

//Google
@property NSString * googleUserId;
@property NSString * googleUserName;
@property NSString * googleUserEmail;
//Facebook
@property NSString * facebookUserId;
@property NSString * facebookUserName;
@property NSString * facebookUserEmail;
//
@property Medicine * medicine;

@end
