//
//  RemindersManager.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

class RemindersManager: NSObject {

    class func medicineWasTaken(rem:Reminder){
        var med:Medicine_Taken = Medicine_Taken.createTakenMedFromMed(rem.medicine,today:NSDate())!
        History.addNewMedicineTaken(med)
    }
    class func medicineWasUntaken(rem:Reminder) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        let start = TimeManager.getStartDayHour()
        let end = TimeManager.getEndDayHour()
        let name = rem.medicineTaken.name
        
        var fetch = NSFetchRequest(entityName: "Medicine_Taken")
        fetch.predicate = NSPredicate(format: "date_time >=  %@ AND date_time <=  %@ AND name = %@",start,end,name)
        
        var array = context?.executeFetchRequest(fetch, error: nil) as! [Medicine_Taken]
        
        History.removeTakenMedicine(array.first!)
        context?.deleteObject(array.first!)
    }
}
