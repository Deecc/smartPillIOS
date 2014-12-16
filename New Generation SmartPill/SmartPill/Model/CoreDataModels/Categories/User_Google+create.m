//
//  User_Google+create.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "User_Google+create.h"

@implementation User_Google (create)

+ (User_Google *)googleUserWithId:(NSString *)googleId
               inManagedObjectContext:(NSManagedObjectContext *)context{
    User_Google * googleUser = nil;
    
    if (googleId>0) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User_Google"];
        request.predicate = [NSPredicate predicateWithFormat:@"idGoogle = %@", googleId];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            return nil;
        } else if (![matches count]) {
            googleUser = [NSEntityDescription insertNewObjectForEntityForName:@"User_Google"
                                                         inManagedObjectContext:context];
            googleUser.idGoogle = googleId;
        } else {
            googleUser = [matches lastObject];
        }
    }
    
    return googleUser;
}
+ (void)UpdateGoogleUserWithId:(NSString *)googleId
          inManagedObjectContext:(NSManagedObjectContext *)context{
    User_Google * googleUser = nil;
    
    if (googleId) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User_Google"];
        
        request.predicate = [NSPredicate predicateWithFormat:@"idgoogle = %@", googleId];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        if (!matches || ([matches count] > 1)) {
            //Handle errors
        } else if (![matches count]) {
            googleUser = [NSEntityDescription insertNewObjectForEntityForName:@"User_Google"
                                                         inManagedObjectContext:context];
            googleUser.idGoogle = googleId;
        } else {
            googleUser = [matches lastObject];
            googleUser.idGoogle = googleId;
        }
    }
}


@end
