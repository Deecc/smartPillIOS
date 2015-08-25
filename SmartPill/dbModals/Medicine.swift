//
//  Medicine.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(Medicine)

public class Medicine: NSManagedObject {

    @NSManaged var activeIngredient: String
    @NSManaged var availability: String
    @NSManaged var idMedicine: NSNumber
    @NSManaged var manufacturer: String
    @NSManaged var name: String
    @NSManaged var quantity: NSNumber
    @NSManaged var recipe: Recipe
    @NSManaged var reminder: NSSet
    @NSManaged var history: History

}
