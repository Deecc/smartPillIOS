//
//  User_Facebook.h
//  SmartPill
//
//  Created by Mobile School - Julian on 1/29/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface User_Facebook : NSManagedObject

@property (nonatomic, retain) NSString * idFacebook;
@property (nonatomic, retain) User *user;

@end
