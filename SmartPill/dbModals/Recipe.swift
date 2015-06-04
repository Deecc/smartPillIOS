//
//  Recipe.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 20/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(Recipe)

class Recipe: NSManagedObject {

    @NSManaged var idRecipe: NSNumber
    @NSManaged var recipeImage: NSData
    @NSManaged var medicine: NSSet

}
