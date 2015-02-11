//
//  User_Google+create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "User_Google.h"

@interface User_Google (create)

+ (User_Google *)googleUserWithId:(NSString *)googleId
               inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)UpdateGoogleUserWithId:(NSString *)googleId
        inManagedObjectContext:(NSManagedObjectContext *)context;
@end
