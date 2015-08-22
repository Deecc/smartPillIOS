//
//  restCon.swift
//
//
//  Created by Dennis da Silva Nunes on 03/06/15.
//  Copyright (c) 2015 Phd Virtual. All rights reserved.
//

import UIKit

class RestCon: NSObject {

    func sendNewMedicineToServer(medicine: Medicine) {
        
        
        if let userIdVerifier = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int{
            //go on
        }else{
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userId")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            print("Usuário não está logado")
            return
        }
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as! Int
        
        var stringUrl = "http://smartpill.noip.me:8080/UsuariosWS/???????"
        
        let myUrl = NSURL(string: stringUrl)
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"

        let postString = "userId=\(userId)&medName=\(medicine.name)&actIngredient=\(medicine.activeIngredient)&manufacturer=\(medicine.manufacturer)&availability=\(medicine.availability)&quant=\(medicine.quantity)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
                
                if(error != nil){
                    print("Problemas ao se conectar ao servidor")
                    return
                }
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                var ans = 0
                if(json != nil){
                    if let answer = json{
                        var ans = answer["Funcionou"] as? Int
                    }
                }
                if ans == 0 {
                    print("Problemas ao se conectar com o servidor")
                }
        }
        task.resume()
    }
    func sendNewReminderToServer(reminder: Reminder) {
        
        
        if let userIdVerifier = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int{
            //go on
        }else{
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userId")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            print("Usuário não está logado")
            return
        }
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as! Int
        
        var stringUrl = "http://smartpill.noip.me:8080/UsuariosWS/???????"
        
        let myUrl = NSURL(string: stringUrl)
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let intToday = TimeManager.convertDateToInt(NSDate())
        
        let postString = "userId=\(userId)&medName=\(reminder.medicine.name)&date=\(intToday)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
                
                if(error != nil){
                    print("Problemas ao se conectar ao servidor")
                    return
                }
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                var ans = 0
                if(json != nil){
                    if let answer = json{
                        var ans = answer["Funcionou"] as? Int
                    }
                }
                if ans == 0 {
                    print("Problemas ao se conectar com o servidor")
                }
        }
        task.resume()
    }
    func sendNewRecipeToServer(recipe: Recipe) {
        
        if let userIdVerifier = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int{
            //go on
        }else{
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userId")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            print("Usuário não está logado")
            return
        }
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as! Int
        
        var stringUrl = "http://smartpill.noip.me:8080/UsuariosWS/???????"
        
        let myUrl = NSURL(string: stringUrl)
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        var medicines:[Medicine] = recipe.medicine.allObjects as! [Medicine]
        var medNames = ""
        
        for med in medicines{
            let first = medicines.first
            if first === med {
                medNames += med.name
            }else{
                medNames += "," + med.name
            }
        }
        
        let postString = "userId=\(userId)&medNames=\(medNames)&photo=\(recipe.recipeImage)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
                
                if(error != nil){
                    print("Problemas ao se conectar ao servidor")
                    return
                }
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                var ans = 0
                if(json != nil){
                    if let answer = json{
                        var ans = answer["Funcionou"] as? Int
                    }
                }
                if ans == 0 {
                    print("Problemas ao se conectar com o servidor")
                }
        }
        task.resume()
    }
    func sendMedicineTakenToServer(medicine: Medicine_Taken) {
        
        
        if let userIdVerifier = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int{
            //go on
        }else{
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userId")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            print("Usuário não está logado")
            return
        }
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as! Int
        
        var stringUrl = "http://smartpill.noip.me:8080/UsuariosWS/???????"
        
        let myUrl = NSURL(string: stringUrl)
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let intToday = TimeManager.convertDateToInt(NSDate())
        
        let postString = "userId=\(userId)&medName=\(medicine.name)&date=\(intToday)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
                
                if(error != nil){
                    print("Problemas ao se conectar ao servidor")
                    return
                }
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                var ans = 0
                if(json != nil){
                    if let answer = json{
                        var ans = answer["Funcionou"] as? Int
                    }
                }
                if ans == 0 {
                    print("Problemas ao se conectar com o servidor")
                }
        }
        task.resume()
    }
    func sendMedicineUnTakenToServer(medicine: Medicine_Taken) {
        
        
        if let userIdVerifier = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int{
            //go on
        }else{
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userId")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            print("Usuário não está logado")
            return
        }
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as! Int
        
        var stringUrl = "http://smartpill.noip.me:8080/UsuariosWS/???????"
        
        let myUrl = NSURL(string: stringUrl)
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let intDate = TimeManager.convertDateToInt(medicine.date_time)
        
        let postString = "userId=\(userId)&medName=\(medicine.name)&date=\(intDate)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
                
                if(error != nil){
                    print("Problemas ao se conectar ao servidor")
                    return
                }
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                var ans = 0
                if(json != nil){
                    if let answer = json{
                        var ans = answer["Funcionou"] as? Int
                    }
                }
                if ans == 0 {
                    print("Problemas ao se conectar com o servidor")
                }
        }
        task.resume()
    }
    func sincronizeWithServer() {
        
        
        if let userIdVerifier = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int{
            //go on
        }else{
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userId")
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            print("Usuário não está logado")
            return
        }
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as! Int
        
        var stringUrl = "http://smartpill.noip.me:8080/UsuariosWS/???????"
        
        let myUrl = NSURL(string: stringUrl)
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let coreDataString = DatabaseGetter.prepareCoreDataToServer()
        
        let postString = "userId=\(userId)" + coreDataString
        
        print(postString)
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
                
                if(error != nil){
                    print("Problemas ao se conectar ao servidor")
                    return
                }
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                var ans = 0
                if(json != nil){
                    if let answer = json{
                        var ans = answer["Funcionou"] as? Int
                    }
                }
                if ans == 0 {
                    print("Problemas ao se conectar com o servidor")
                }
        }
        task.resume()
    }
}
