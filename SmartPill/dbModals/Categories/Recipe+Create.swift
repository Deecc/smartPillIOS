//
//  Recipe+Create.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 20/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import CoreData

extension Recipe{
    
    class func createRecipe(medicine:Medicine,recipeImage:NSData?)->Recipe?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        if(recipeImage != nil){
            let request = NSFetchRequest(entityName: "Recipe")
            request.predicate = NSPredicate(format: "recipeImage = %@", recipeImage!)
            
            var matches = context!.executeFetchRequest(request, error: nil) as? [Recipe]
            
            if(matches == nil || matches!.count > 1){
                return nil
            }else if(matches!.count==0){
                //CREATE A NEW OFFER
                var rec = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: context!) as! Recipe
                
                rec.recipeImage = recipeImage!
                if (rec.medicine.count==0){
                    var set = Set([medicine])
                    rec.medicine = set
                }else{
                    var array:NSMutableArray = rec.medicine.allObjects as! NSMutableArray
                    array.addObject(medicine)
                    rec.medicine.setByAddingObjectsFromArray(array as [AnyObject])
                }
                context?.save(nil)
                return rec
            }else{
                //OVERWRITE THE OLD OFFER
                var rec:Recipe = matches!.first!
                var array:NSMutableArray = rec.medicine.allObjects as! NSMutableArray
                array.addObject(medicine)
                rec.medicine.setByAddingObjectsFromArray(array as [AnyObject])
                rec.recipeImage = recipeImage!
                context?.save(nil)
                return rec
            }
        }
        return nil
    }
}