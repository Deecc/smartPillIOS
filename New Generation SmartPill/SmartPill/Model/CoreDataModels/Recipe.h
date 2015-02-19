//
//  Recipe.h
//  SmartPill
//
//  Created by Mobile School - Julian on 1/29/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medicine;

@interface Recipe : NSManagedObject
@property (nonatomic, retain) NSNumber * idRecipe;
@property (nonatomic, retain) NSData * recipeImage;
@property (nonatomic, retain) NSSet *medicine;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addMedicineObject:(Medicine *)value;
- (void)removeMedicineObject:(Medicine *)value;
- (void)addMedicine:(NSSet *)values;
- (void)removeMedicine:(NSSet *)values;

@end
