//
//  Recipe.h
//  SmartPill
//
//  Created by Mobile School - Thiago on 20/01/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medicine;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSNumber * idRecipe;
@property (nonatomic, retain) NSData * recipeImage;
@property (nonatomic, retain) Medicine *medicine;

@end
