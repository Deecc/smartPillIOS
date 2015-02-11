//
//  User+create.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "User.h"

@interface User (create)

+ (User *)userWithName:(NSString *)name
                 Email:(NSString *)email
              password:(NSString *)password
inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)UpdateUserWithName:(NSString *)name
                     Email:(NSString *)email
                  password:(NSString *)password
    inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSDictionary*)getDictionaryVersionFrom:(User*)user;
@end
