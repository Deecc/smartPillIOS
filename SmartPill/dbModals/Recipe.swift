//
//  Recipe.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(Recipe)

public class Recipe: NSManagedObject {

    @NSManaged var idRecipe: NSNumber
    @NSManaged var recipeImage: NSData
    @NSManaged var medicine: NSSet
    @NSManaged var medicineTaken: NSSet

}
