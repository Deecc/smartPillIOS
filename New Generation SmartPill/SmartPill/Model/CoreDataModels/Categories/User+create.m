//
//  User+create.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "User+create.h"

@implementation User (create)

+ (User *)userWithName:(NSString *)name
                 Email:(NSString *)email
              password:(NSString *)password
inManagedObjectContext:(NSManagedObjectContext *)context{
    User * user = nil;
    
    if ([email length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"email = %@", email];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            return nil;
        } else if (![matches count]) {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                       inManagedObjectContext:context];
            user.name = name;
            user.email = email;
            user.password = password;
        } else {
            user = [matches lastObject];
        }
    }
    
    return user;
}
+ (void)UpdateUserWithName:(NSString *)name
                 Email:(NSString *)email
              password:(NSString *)password
inManagedObjectContext:(NSManagedObjectContext *)context{
    User * user = nil;
    
    if ([email length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"email = %@", email];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
           //Handle errors here
        } else if (![matches count]) {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                 inManagedObjectContext:context];
            user.name = name;
            user.email = email;
            user.password = password;
        } else {
            user = [matches lastObject];
            user.name = name;
            user.email = email;
            user.password = password;
        }
    }
}

+ (NSDictionary*)getDictionaryVersionFrom:(User*)user{
    NSDictionary * userDictionary = [NSDictionary dictionaryWithObjectsAndKeys:user.idUser,@"id",user.email,@"email",user.name,@"name",user.password,@"pass",nil];
#pragma mark - completar depois do banco estar atualizado
    return userDictionary;
}

@end
