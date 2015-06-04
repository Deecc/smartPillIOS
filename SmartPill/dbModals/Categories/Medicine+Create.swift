//
//  Medicine+Create.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 20/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

extension Medicine{
    
    class func createMedicine(activeIngredient:String,availability:String,manufacturer:String,name:String,quantity:NSNumber,recipe:Recipe?,reminder:NSSet?)->Medicine?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        if(count(name)>0){
            let request = NSFetchRequest(entityName: "Medicine")
            request.predicate = NSPredicate(format: "name = %@", name)
            
            var matches = context!.executeFetchRequest(request, error: nil) as? [Medicine]
            
            if(matches == nil || matches!.count > 1){
                return nil
            }else if(matches!.count==0){
                //CREATE A NEW OFFER
                var med = NSEntityDescription.insertNewObjectForEntityForName("Medicine", inManagedObjectContext: context!) as! Medicine
                
                med.activeIngredient = activeIngredient
                med.availability = availability
                med.manufacturer = manufacturer
                med.name = name
                med.quantity = quantity
                if(recipe != nil){med.recipe = recipe!}
                if(reminder != nil){med.reminder = reminder!}
                context?.save(nil)
                return med
            }else{
                //OVERWRITE THE OLD OFFER
                var med:Medicine = matches!.first!
                
                med.activeIngredient = activeIngredient
                med.availability = availability
                med.manufacturer = manufacturer
                med.name = name
                med.quantity = quantity
                if(recipe != nil){med.recipe = recipe!}
                if(reminder != nil){med.reminder = reminder!}
                context?.save(nil)
                return med
            }
        }
        return nil
    }
}