//
//  User_Facebook+Create.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "User_Facebook+Create.h"

@implementation User_Facebook (Create)

+ (User_Facebook *)facebookUserWithId:(NSString *)facebookId
               inManagedObjectContext:(NSManagedObjectContext *)context{
    User_Facebook * facebookUser = nil;

    if (facebookId) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User_Facebook"];
        
        request.predicate = [NSPredicate predicateWithFormat:@"idFacebook = %@", facebookId];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        if (!matches || ([matches count] > 1)) {
            return nil;
        } else if (![matches count]) {
            facebookUser = [NSEntityDescription insertNewObjectForEntityForName:@"User_Facebook"
                                                         inManagedObjectContext:context];
            facebookUser.idFacebook = facebookId;
        } else {
            facebookUser = [matches lastObject];
        }
    }
    return facebookUser;
}
+ (void)UpdateFacebookUserWithId:(NSString *)facebookId
               inManagedObjectContext:(NSManagedObjectContext *)context{
    User_Facebook * facebookUser = nil;
    
    if (facebookId) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User_Facebook"];
        
        request.predicate = [NSPredicate predicateWithFormat:@"idFacebook = %@", facebookId];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        if (!matches || ([matches count] > 1)) {
            //Handle errors
        } else if (![matches count]) {
            facebookUser = [NSEntityDescription insertNewObjectForEntityForName:@"User_Facebook"
                                                         inManagedObjectContext:context];
            facebookUser.idFacebook = facebookId;
        } else {
            facebookUser = [matches lastObject];
            facebookUser.idFacebook = facebookId;
        }
    }
}

@end
