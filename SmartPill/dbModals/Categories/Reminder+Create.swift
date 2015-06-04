//
//  Reminder+Create.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 20/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

extension Reminder{
    
    class func createReminder(medicine:Medicine?,remSchedule:Reminder_Schedule,remSound:Reminder_Sound?)->Reminder?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        if((medicine) != nil){
            let medicineName = medicine?.name
            
            let request = NSFetchRequest(entityName: "Medicine")
            request.predicate = NSPredicate(format: "name = %@", medicineName!)
            
            var matches = context!.executeFetchRequest(request, error: nil) as? [Medicine]
            if(matches == nil || matches!.count > 1){
                return nil
            }else if(matches!.count==1){
                for m in matches! {
                    if(m.name == medicineName){
                    var rem = NSEntityDescription.insertNewObjectForEntityForName("Reminder", inManagedObjectContext: context!) as! Reminder
                    rem.medicine = m
                    rem.reminder_schedule = remSchedule
                    if remSound != nil {rem.reminder_sound = remSound!}
                    context?.save(nil)
                    return rem
                    }
                }
            }else{
                return nil
            }
        }
        return nil
    }
}