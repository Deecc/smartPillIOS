//
//  SPMoreViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 02/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SPUserHandler.h"

@interface SPMoreViewController : UITableViewController<FBLoginViewDelegate>

//Facebook
@property NSString * facebookUserId;
@property NSString * facebookUserName;
@property NSString * facebookUserEmail;


@end
