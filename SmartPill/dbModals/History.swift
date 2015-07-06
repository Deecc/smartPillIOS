//
//  History.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(History)

class History: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var not_taken: NSSet
    @NSManaged var taken: NSSet

}
