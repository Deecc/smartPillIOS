//
//  Reminder_Sound.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 20/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(Reminder_Sound)

class Reminder_Sound: NSManagedObject {

    @NSManaged var idReminderSound: NSNumber
    @NSManaged var reminder: NSSet

}
