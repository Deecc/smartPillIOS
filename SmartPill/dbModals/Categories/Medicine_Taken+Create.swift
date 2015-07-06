//
//  Medicine_Taken+Create.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

extension Medicine_Taken{
    class func createTakenMedFromMed(med:Medicine,today:NSDate) -> Medicine_Taken?{
        med.decreaseQuantity(1)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Medicine_Taken")
        request.predicate = NSPredicate(format: "name = %@", med.name)
            
        var matches = context!.executeFetchRequest(request, error: nil) as? [Medicine_Taken]
        
        var array:[Medicine_Taken] = getTakenMedWithDate(NSDate(),array:matches!)
        
        
        if(array.count > 1){
            return nil
        }else if(array.count==0){
            //CREATE A NEW MEDICINE
            var medTaken = NSEntityDescription.insertNewObjectForEntityForName("Medicine_Taken", inManagedObjectContext: context!) as! Medicine_Taken
                
            medTaken.activeIngredient = med.activeIngredient
            medTaken.availability = med.availability
            medTaken.manufacturer = med.manufacturer
            medTaken.name = med.name
            medTaken.quantity = NSNumber(int: 1)
            medTaken.recipe = med.recipe
            medTaken.reminder = med.reminder
            medTaken.date_time = NSDate()
                
            context?.save(nil)
            return medTaken
        }else{
            //OVERWRITE THE OLD MEDICINE
            var medTaken:Medicine_Taken = array.first!
            
            medTaken.activeIngredient = med.activeIngredient
            medTaken.availability = med.availability
            medTaken.manufacturer = med.manufacturer
            medTaken.name = med.name
            medTaken.quantity = NSNumber(int: 1)
            medTaken.recipe = med.recipe
            medTaken.reminder = med.reminder
            medTaken.date_time = NSDate()

            context?.save(nil)
            return medTaken
        }
    }
    class func getTakenMedWithDate(date:NSDate,array:[Medicine_Taken]) -> [Medicine_Taken]{
        var arrayToday:[Medicine_Taken] = []
        for med:Medicine_Taken in array {
            if med.date_time == NSDate(){
                arrayToday.append(med)
            }
        }
        return arrayToday
    }

}