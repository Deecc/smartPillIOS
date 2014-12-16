//
//  User_Google.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/12/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface User_Google : NSManagedObject

@property (nonatomic, retain) NSString * idGoogle;
@property (nonatomic, retain) User *user;

@end
