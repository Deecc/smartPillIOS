//
//  SPUser.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 24/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPUser : NSObject

@property NSString * name;
@property NSString * email;
@property NSNumber * userId;
@property NSString * userFacebookId;
@property NSString * userGoogleId;
@property NSString * password;
@property NSMutableArray * listOfMedicine;

@end
