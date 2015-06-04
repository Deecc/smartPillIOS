//
//  Reminder_Schedule+Create.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 20/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

extension Reminder_Schedule{
    
    class func createReminderSchedule(reminders:NSSet?,date:NSDate?)->Reminder_Schedule?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        if ((date) != nil) {
            let request = NSFetchRequest(entityName: "Reminder_Schedule")
            request.predicate = NSPredicate(format: "schedule = %@", date!)
            
            var matches = context!.executeFetchRequest(request, error: nil) as? [Reminder_Schedule]
            
            if(matches == nil || matches!.count > 1){
                return nil
            }else if(matches!.count==0){
                //CREATE A NEW OFFER
                var dat = NSEntityDescription.insertNewObjectForEntityForName("Reminder_Schedule", inManagedObjectContext: context!) as! Reminder_Schedule
                
                dat.schedule = date!
                if(reminders != nil){dat.reminder = reminders!}
                context?.save(nil)
                return dat
            }else{
                //OVERWRITE THE OLD OFFER
                var dat:Reminder_Schedule = matches!.first!
                
                dat.schedule = date!
                if(reminders != nil){dat.reminder = reminders!}
                context?.save(nil)
                return dat
            }
        }
        return nil
    }
}