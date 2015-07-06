//
//  Medicine_Taken.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(Medicine_Taken)

class Medicine_Taken: NSManagedObject {

    @NSManaged var activeIngredient: String
    @NSManaged var availability: String
    @NSManaged var idMedicine: NSNumber
    @NSManaged var manufacturer: String
    @NSManaged var name: String
    @NSManaged var quantity: NSNumber
    @NSManaged var date_time: NSDate
    @NSManaged var history: History
    @NSManaged var recipe: Recipe
    @NSManaged var reminder: NSSet

}
