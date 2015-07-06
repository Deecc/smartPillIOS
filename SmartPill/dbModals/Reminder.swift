//
//  Reminder.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import Foundation
import CoreData
@objc(Reminder)

class Reminder: NSManagedObject {

    @NSManaged var idReminder: NSNumber
    @NSManaged var medicine: Medicine
    @NSManaged var reminder_schedule: Reminder_Schedule
    @NSManaged var reminder_sound: Reminder_Sound
    @NSManaged var medicineTaken: Medicine_Taken

}
