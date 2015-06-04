//
//  Reminder_Schedule.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 20/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(Reminder_Schedule)

class Reminder_Schedule: NSManagedObject {

    @NSManaged var idReminderSchedule: NSNumber
    @NSManaged var schedule: NSDate
    @NSManaged var reminder: NSSet

}
