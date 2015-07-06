//
//  History+Create.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

extension History{
    
    class func createToday()->History?{
        var newDate = TimeManager.getStartDayHour()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        
        
        let request = NSFetchRequest(entityName: "History")
        request.predicate = NSPredicate(format: "date = %@", newDate)
        
        var matches = context.executeFetchRequest(request, error: nil) as? [History]
        
        if(matches == nil || matches!.count > 1){
            return nil
        }else if(matches!.count==0){
            //CREATE A NEW HISTORY
        
            var his = NSEntityDescription.insertNewObjectForEntityForName("History", inManagedObjectContext: context) as! History
            
            his.date = newDate
            let arrNotTaken = getNotTaken()
            if arrNotTaken.count>0 {
                his.not_taken = NSSet(array: arrNotTaken)
            }
            his.taken = NSSet()
            context.save(nil)

            return his
        }else{
            //OVERWRITE THE OLD HISTORY
            var his:History = matches!.first!
            let arrTaken = getTaken()
            let arrNotTaken = getNotTaken()
            if arrTaken.count>0 {
                his.taken = NSSet(array: arrTaken)
            }
            if arrNotTaken.count>0 {
                his.not_taken = NSSet(array: arrNotTaken)
            }
            context.save(nil)
            return his
        }
    }
    class func getTaken() -> [Medicine_Taken]{
        var arrayRem = DatabaseGetter.getReminders()! as [Reminder]
        var arrayMed:[Medicine_Taken] = []
        for reminder in arrayRem {
            let rem:Medicine_Taken?
            rem = reminder.medicineTaken
            if rem != nil {
                arrayMed.append(rem!)
            }
        }
        return arrayMed
    }
    class func getNotTaken() -> [Medicine] {
        var arrayRem = DatabaseGetter.getReminders()! as [Reminder]
        var arrayMed:[Medicine] = []
        for reminder in arrayRem {
            arrayMed.append(reminder.medicine)
        }
        var arrayMedTaken:[Medicine_Taken] = getTaken()
        for med in arrayMed {
            for medTaken in arrayMedTaken{
                arrayMed = arrayMed.filter( {$0.name != medTaken.name} )
            }
        }
        return arrayMed
    }
    
    class func addNewMedicineTaken(med:Medicine_Taken){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "History")
        let start = TimeManager.getStartDayHour()
        let end = TimeManager.getEndDayHour()
        
        request.predicate = NSPredicate(format: "date >=  %@ AND date <=  %@",start,end)
        
        
        var matches = context!.executeFetchRequest(request, error: nil) as? [History]
        var history:History = matches!.first!
        
        var setTaken = NSMutableSet(set: history.taken)
        setTaken.addObject(med)
        
        var setUntaken = NSMutableSet(set: history.not_taken)
        for medUntaken in setUntaken {
            if medUntaken.name == med.name {
                setUntaken.removeObject(medUntaken)
            }
        }
        
        history.taken = setTaken
        history.not_taken = setUntaken
    }
    
    class func removeTakenMedicine(med:Medicine_Taken){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "History")
        let start = TimeManager.getStartDayHour()
        let end = TimeManager.getEndDayHour()

        request.predicate = NSPredicate(format: "date >=  %@ AND date <=  %@",start,end)
        
        var matches = context!.executeFetchRequest(request, error: nil) as? [History]
        var history:History = matches!.first!
        
        var setTaken = NSMutableSet(set: history.taken)
        setTaken.removeObject(med)
        var setUntaken = NSMutableSet(set: history.not_taken)
        var medUntaken:Medicine = DatabaseGetter.getMedicineWithName(med.name)!
        medUntaken.increaseQuantity(1)
        setUntaken.addObject(medUntaken)
        
        history.taken = setTaken
        history.not_taken = setUntaken
    }
    
}