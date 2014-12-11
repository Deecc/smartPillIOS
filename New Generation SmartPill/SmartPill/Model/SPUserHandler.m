//
//  SPUserHandler.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 24/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPUserHandler.h"

@implementation SPUserHandler

+ (SPUser*)createUserWithName:(NSString*)name
                        Email:(NSString*)email
                       UserId:(NSString*)userId
                  andPassword:(NSString *)password{
    if (name != nil && email != nil) {
        SPUser * user = [[SPUser alloc] initWithName:name Email:email UserId:userId andPassword:password];
                return user;
    }else{
        return nil;
    }
}
+ (void)deleteUser:(SPUser*)user{
    //RETIRAR DO BANCO/APAGAR ARQUIVO
}
+ (void)updateUser:(SPUser*)user
          withName:(NSString*)name
             Email:(NSString*)email
            UserId:(NSString*)userId
       andPassword:(NSString*)password;{
    if (name != nil) {user.name = name;}
    if (email != nil) {user.email = email;}
    user.userId = userId;
    user.password = password;
    //Update name,email e userId do user
}
+ (SPUser*)getLastUser{
//PEGAR USUARIO DO BANCO/ARQUIVO
    SPUser * user;
    return user;
}

+ (void)sendUserToLocalDatabase:(SPUser*)user{
    //Enviando para o banco local
}

+ (void)sendUserToRemoteDatabase:(SPUser*)user{
    //Enviando para o banco remoto
}

+ (BOOL)doesUserExist:(SPUser*)user{
    if ([self checkUserPresenceLocally:user] && [self checkUserPresenceRemotely:user]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)checkUserPresenceLocally:(SPUser*)user{
    //Procura usuário no banco local
    return YES;
}
+ (BOOL)checkUserPresenceRemotely:(SPUser*)user{
    //Procura usuário no servidor
    return YES;
}

+ (void)updateUserDataFromServer:(SPUser*)user{
    //Atualizar usúario com dados do servidor
}

@end
