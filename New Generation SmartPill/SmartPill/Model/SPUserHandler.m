//
//  SPUserHandler.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 24/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//
#import "SPViewController.h"
#import "SPUserHandler.h"
#import "SPAppDelegate.h"
#import "Medicine.h"

@implementation SPUserHandler
+ (SPUser*)createFacebookUserWithName:(NSString*)name
                                       Email:(NSString*)email
                              UserFacebookId:(NSString*)userFacebookId{
    SPUser * facebookUser = [[SPUser alloc]init];
    facebookUser.name = name;
    facebookUser.email = email;
    facebookUser.userFacebookId = userFacebookId;
    return facebookUser;
}
+ (SPUser*)createGoogleUserWithName:(NSString*)name
                                   Email:(NSString*)email
                            UserGoogleId:(NSString*)userGoogleId{
    SPUser * googleUser = [[SPUser alloc]init];
    googleUser.name = name;
    googleUser.email = email;
    googleUser.userGoogleId = userGoogleId;
    return googleUser;
}
+ (SPUser*)createUserWithName:(NSString*)name
                        Email:(NSString*)email
                       UserId:(NSNumber*)userId
                  andPassword:(NSString *)password{
    if (name != nil && email != nil && password != nil) {
        SPUser * user = [[SPUser alloc] init];
        user.name = name;
        user.email = email;
        user.userId = userId;
        user.password = password;
        return user;
    }else{
        return nil;
    }
}
+ (void)deleteUser:(SPUser*)user fromDataBase:(NSManagedObjectContext*)context{
    //RETIRAR DO BANCO/APAGAR ARQUIVO
    NSArray * usersArray = [self checkPresenceToReturnUserLocally:user OnDataBase:context];
    for (User *dataBaseUser in usersArray) {
        if ([dataBaseUser.email isEqualToString:user.email]) {
            NSLog(@"user to be deleted %@",dataBaseUser.name);
            [context deleteObject:dataBaseUser];
        }
    }
    [context save:nil];
}
+ (void)updateUser:(SPUser*)user
          withName:(NSString*)name
             Email:(NSString*)email
            UserId:(NSNumber*)userId
       andPassword:(NSString*)password;{
    if (name != nil) {user.name = name;}
    if (email != nil) {user.email = email;}
    user.userId = userId;
    user.password = password;
    //Update name,password,email e userId do user
}

+ (void)sendUser:(SPUser*)user toLocalDatabase:(NSManagedObjectContext*)context{
    //Enviando para o banco local
    User * dataBaseUser = [User userWithName:user.name Email:user.email password:user.password inManagedObjectContext:context];
    if (user.userFacebookId) {
        dataBaseUser.facebook = [User_Facebook facebookUserWithId:user.userFacebookId inManagedObjectContext:context];
    }else if (user.userGoogleId){
        dataBaseUser.google = [User_Google googleUserWithId:user.userGoogleId inManagedObjectContext:context];
    }
    [context save:nil];
    [context reset];
}

+ (void)sendUserToRemoteDatabase:(SPUser*)user{
    //Enviando para o banco remoto
}

+ (BOOL)doesUserExist:(SPUser*)user OnDataBase:(NSManagedObjectContext*)context{
    if ([self checkUserPresenceLocally:user OnDataBase:context] && [self checkUserPresenceRemotely:user]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)checkUserPresenceLocally:(SPUser*)user OnDataBase:(NSManagedObjectContext*)context{
    //Procura usuário no banco local
    if ([self checkPresenceToReturnUserLocally:user OnDataBase:context]) {
        return YES;
    }else{
        return NO;
    }
}
+ (NSArray*)checkPresenceToReturnUserLocally:(SPUser*)user OnDataBase:(NSManagedObjectContext*)context{
    // Normally build this in some kind of loop
    NSPredicate *facebookPredicate = [NSPredicate predicateWithFormat:@"facebook.idFacebook =%@", user.userFacebookId];
    NSPredicate *googlePredicate = [NSPredicate predicateWithFormat:@"google.idGoogle =%@", user.userGoogleId];
    NSPredicate *smartpillPredicate = [NSPredicate predicateWithFormat:@"email =%@", user.email];
    // Create the array of predicates
    NSArray *arrayOfPredicates = [NSArray arrayWithObjects:facebookPredicate, googlePredicate,smartpillPredicate, nil];
    // Create the compound predicate
    NSPredicate * compoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:arrayOfPredicates];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    fetch.predicate = compoundPredicate;
    
    NSError * error;
    NSArray *array = [context executeFetchRequest:fetch error:&error];
    if (error == nil && [array count]>0) {
        for (User * usr in array) {
            if ([usr.email isEqualToString:user.email]) {
                return array;
            }
        }
        NSLog(@"checkPresenceToReturnUserLocally nil (User Not Found)");
        return nil;
    }else{
        NSLog(@"checkPresenceToReturnUserLocally nil 2 (No Users)");
        return nil;
    }
}

+ (BOOL)checkUserPresenceRemotely:(SPUser*)user{
    //Procura usuário no servidor
    return YES;
}

+ (void)updateUserDataFromServer:(SPUser*)user{
    //Atualizar usúario com dados do servidor
    
}

+ (void)dataFromDatabase{
    SPAppDelegate * appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * context = appdelegate.managedObjectContext;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSError * error;
    NSArray * array = [context executeFetchRequest:fetch error:&error];
    if (array) {
        for (User * user in array) {
            NSLog(@"User name is %@",user.name);
        }
    }else{
        NSLog(@"Banco sem usuários");
    }
}
@end
