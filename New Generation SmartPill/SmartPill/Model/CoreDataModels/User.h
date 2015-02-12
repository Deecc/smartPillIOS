//
//  User.h
//  SmartPill
//
//  Created by Mobile School - Julian on 1/29/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medicine, User_Facebook, User_Google;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * idUser;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) User_Facebook *facebook;
@property (nonatomic, retain) User_Google *google;
@property (nonatomic, retain) NSSet *medicine;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMedicineObject:(Medicine *)value;
- (void)removeMedicineObject:(Medicine *)value;
- (void)addMedicine:(NSSet *)values;
- (void)removeMedicine:(NSSet *)values;

@end
