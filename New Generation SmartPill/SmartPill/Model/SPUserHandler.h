//
//  SPUserHandler.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 24/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPUser.h"
#import "User.h"
#import "User+create.h"
#import "User_Facebook.h"
#import "User_Facebook+Create.h"
#import "User_Google.h"
#import "User_Google+create.h"
#import "SPConnectionRest.h"

@interface SPUserHandler : NSObject

+ (SPUser*)createFacebookUserWithName:(NSString*)name
                                Email:(NSString*)email
                       UserFacebookId:(NSString*)userFacebookId;
+ (SPUser*)createGoogleUserWithName:(NSString*)name
                              Email:(NSString*)email
                       UserGoogleId:(NSString*)userGoogleId;
+ (SPUser*)createUserWithName:(NSString*)name
                        Email:(NSString*)email
                       UserId:(NSNumber*)userId
                  andPassword:(NSString*)password;
+ (void)deleteUser:(SPUser*)user
      fromDataBase:(NSManagedObjectContext*)context;
+ (void)updateUser:(SPUser*)user
          withName:(NSString*)name
             Email:(NSString*)email
            UserId:(NSNumber*)userId
       andPassword:(NSString*)password;
+ (void)sendUser:(SPUser*)user toLocalDatabase:(NSManagedObjectContext*)context;
+ (void)sendUserToRemoteDatabase:(User*)user;
+ (BOOL)doesUserExist:(SPUser*)user
           OnDataBase:(NSManagedObjectContext*)context;
+ (BOOL)checkUserPresenceLocally:(SPUser*)user
                      OnDataBase:(NSManagedObjectContext*)context;
+ (BOOL)checkUserPresenceRemotely:(SPUser*)user;
+ (void)updateUserDataFromServer:(SPUser*)user;
+ (void)dataFromDatabase;
+ (NSArray*)checkPresenceToReturnUserLocally:(SPUser*)user OnDataBase:(NSManagedObjectContext*)context;
+ (User*)getCurrentDatabaseUser;
+ (User*)getOneUserFromDatabase;
@end
