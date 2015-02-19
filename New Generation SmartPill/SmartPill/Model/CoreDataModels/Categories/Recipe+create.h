//
//  Recipe+create.h
//  SmartPill
//
//  Created by Mobile School - Julian on 2/19/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "Recipe.h"

@interface Recipe (create)
+ (Recipe *)createRecipe:(Medicine *)medicine
inManagedObjectContext:(NSManagedObjectContext *)context;
@end
