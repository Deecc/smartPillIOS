//
//  DatabaseGetter.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 23/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

class DatabaseGetter: NSObject {
    
    class func getRemindersFromHistory() -> [Reminder]{
        createHistoryToday()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "History")
        let today = TimeManager.getStartDayHour()
        fetch.predicate = NSPredicate(format: "date = %@", today)
        var array = context.executeFetchRequest(fetch, error: nil) as! [History]
        return getRemindersInHistory(array)
    }
    class func createHistoryToday(){
        History.createToday()
    }
    
    class func getRemindersInHistory(arrHistory:[History])->[Reminder]{
        var array:[Reminder] = []
        for history in  arrHistory{
            let medicines = history.not_taken.allObjects as! [Medicine]
            for med in medicines{
                let rems = med.reminder.allObjects as! [Reminder]
                for rem in rems {
                    array.append(rem)
                }
            }
        }
        return array
    }
    
    class func getRemindersFromTakenHistory() -> [Reminder]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "History")
        let today = TimeManager.getStartDayHour()
        fetch.predicate = NSPredicate(format: "date = %@", today)
        var array = context?.executeFetchRequest(fetch, error: nil) as! [History]
        return getRemindersInTakenHistory(array)
    }
    
    class func getRemindersInTakenHistory(arrHistory:[History])->[Reminder]{
        var array:[Reminder] = []
        for history in  arrHistory{
            let medicines = history.taken.allObjects as! [Medicine_Taken]
            for med in medicines{
                let rems = med.reminder.allObjects as! [Reminder]
                for rem in rems {
                    array.append(rem)
                }
            }
        }
        return array
    }

    class func getMedicines()->[Medicine]?{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Medicine")

        var array = context?.executeFetchRequest(fetch, error: nil) as! [Medicine]
        return array
    }
    
    class func getMedicineWithName(name:String)->Medicine?{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Medicine")
        
        var array = context?.executeFetchRequest(fetch, error: nil) as! [Medicine]
        
        for m in array{
            if m.name == name{
                return m
            }
        }
        return nil
    }
    class func getRemindersSchedule()->[Reminder_Schedule]?{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Reminder_Schedule")
        
        var array = context?.executeFetchRequest(fetch, error: nil) as! [Reminder_Schedule]
        return array
    }
    class func getReminders()->[Reminder]?{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Reminder")
        
        var array = context?.executeFetchRequest(fetch, error: nil) as! [Reminder]
        return array
    }
    
    class func getRecipes()->[Recipe]?{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Recipe")
        
        var array = context?.executeFetchRequest(fetch, error: nil) as! [Recipe]
        return array
    }
    class func getRemindersSound()->[Reminder_Sound]?{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Reminder_Sound")
        
        var array = context?.executeFetchRequest(fetch, error: nil) as! [Reminder_Sound]
        return array
    }
}
