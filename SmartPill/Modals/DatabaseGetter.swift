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

    class func getMedicines()->[Medicine]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Medicine")

        if let array = context!.executeFetchRequest(fetch, error: nil) as? [Medicine]{
            return array
        }else{
            return [Medicine]()
        }
    }
    
    class func getMedicinesTaken()->[Medicine_Taken]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var fetch = NSFetchRequest(entityName: "Medicine_Taken")
        
        if let array = context!.executeFetchRequest(fetch, error: nil) as? [Medicine_Taken]{
            return array
        }else{
            return [Medicine_Taken]()
        }
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
    class func getReminders()->[Reminder]{
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
    
    class func prepareCoreDataToServer()->String{
        let meds = transformMedicineArray(getMedicines())
        let takenMeds = transformMedicineTakenArray(getMedicinesTaken())
        let reminders = transformReminderArray(getReminders())
        //let recipe = getRecipes()
        
        return "&medsNameQt=\(meds)&medsTakenNameQtDate=\(takenMeds)&remMedsNameDate=\(reminders)"
    }
//CONVERT COREDATA TO STRING
    class func transformMedicineArray(meds:[Medicine])->String{
        var medNamesQt = ""
        
        for med in meds{
            let first = meds.first
            if first === med {
                medNamesQt += med.name + "," + "\(med.quantity)"
            }else{
                medNamesQt += "," + med.name + "\(med.quantity)"
            }
        }
        
        return medNamesQt
    }
    class func transformMedicineTakenArray(meds:[Medicine_Taken])->String{
        var medNamesQtDate = ""
        
        for med in meds{
            let first = meds.first
            var intDate = TimeManager.convertDateToInt(med.date_time)
            if first === med {
                medNamesQtDate += med.name + "," + "\(med.quantity)" + "\(intDate)"
            }else{
                medNamesQtDate += "," + med.name + "\(med.quantity)" + "\(intDate)"
            }
        }
        return medNamesQtDate
    }
    
    class func transformReminderArray(reminders:[Reminder])->String{
        var medNamesDate = ""
        
        for rem in reminders{
            let first = reminders.first!.medicine
            var intDate = TimeManager.convertDateToInt(rem.reminder_schedule.schedule)
            if first === rem.medicine {
                medNamesDate += rem.medicine.name + "," + "\(intDate)"
            }else{
                medNamesDate += "," + rem.medicine.name + "," + "\(intDate)"
            }
        }
        return medNamesDate
    }
}
