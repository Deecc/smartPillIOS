//
//  Recipe+create.m
//  SmartPill
//
//  Created by Mobile School - Julian on 2/19/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "Recipe+create.h"

@implementation Recipe (create)
+ (Recipe *)createRecipe:(Medicine *)medicine
  inManagedObjectContext:(NSManagedObjectContext *)context{
    Recipe * recipe = nil;
    medicine = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
    [recipe addMedicineObject:medicine];
    return recipe;
}
@end
