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
#import <CoreData/CoreData.h>
#import "SPAppDelegate.h"

@class GPPSignInButton;

@interface SPViewController : UIViewController<FBLoginViewDelegate,GPPSignInDelegate,NSFetchedResultsControllerDelegate, UITextFieldDelegate>

//Google
@property NSString * googleUserId;
@property NSString * googleUserName;
@property NSString * googleUserEmail;
//Facebook
@property NSString * facebookUserId;
@property NSString * facebookUserName;
@property NSString * facebookUserEmail;
//CoreData
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
