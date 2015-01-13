//
//  User.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 12/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Remedios, User_Facebook, User_Google;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * idUser;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) User_Facebook *facebook;
@property (nonatomic, retain) User_Google *google;
@property (nonatomic, retain) NSSet *remedios;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addRemediosObject:(Remedios *)value;
- (void)removeRemediosObject:(Remedios *)value;
- (void)addRemedios:(NSSet *)values;
- (void)removeRemedios:(NSSet *)values;

@end
