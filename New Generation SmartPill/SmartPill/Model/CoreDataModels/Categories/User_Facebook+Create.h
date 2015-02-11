//
//  User_Facebook+Create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "User_Facebook.h"

@interface User_Facebook (Create)

+ (User_Facebook *)facebookUserWithId:(NSString *)facebookId
                inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)UpdateFacebookUserWithId:(NSString *)facebookId
          inManagedObjectContext:(NSManagedObjectContext *)context;

@end
