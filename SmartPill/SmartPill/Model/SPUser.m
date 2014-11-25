//
//  SPUser.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 24/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPUser.h"

@interface SPUser()

@end

@implementation SPUser

- (instancetype)initWithName:(NSString*)name
                       Email:(NSString*)email
                      UserId:(NSString*)userId
                 andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.name = name;
        self.email = email;
        self.userId = userId;
        self.password = password;
        self.listOfMedicine = @[];
    }
    return self;
}

- (NSString *)description{
    NSString * description = [NSString stringWithFormat:@"User: %@, Email: %@, Id: %@",self.name,self.email,self.userId];
    return description;
}

@end
