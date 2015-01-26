//
//  User_Google.h
//  SmartPill
//
//  Created by Mobile School - Thiago on 13/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface User_Google : NSManagedObject

@property (nonatomic, retain) NSString * idGoogle;
@property (nonatomic, retain) User *user;

@end
