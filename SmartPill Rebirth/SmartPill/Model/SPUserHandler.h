//
//  SPUserHandler.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 24/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPUser.h"

@interface SPUserHandler : NSObject
+ (SPUser*)createUserWithName:(NSString*)name
                        Email:(NSString*)email
                       UserId:(NSString*)userId
                  andPassword:(NSString*)password;
+ (void)deleteUser:(SPUser*)user;
+ (void)updateUser:(SPUser*)user
          withName:(NSString*)name
             Email:(NSString*)email
            UserId:(NSString*)userId
       andPassword:(NSString*)password;
+ (SPUser*)getLastUser;
+ (void)sendUserToLocalDatabase:(SPUser*)user;
+ (void)sendUserToRemoteDatabase:(SPUser*)user;
+ (BOOL)doesUserExist:(SPUser*)user;
+ (BOOL)checkUserPresenceLocally:(SPUser*)user;
+ (BOOL)checkUserPresenceRemotely:(SPUser*)user;
+ (void)updateUserDataFromServer:(SPUser*)user;
@end
