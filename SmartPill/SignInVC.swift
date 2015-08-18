//
//  SignInVC.swift
//  Natal Urbano
//
//  Created by Dennis da Silva Nunes on 13/05/15.
//  Copyright (c) 2015 Phd Virtual. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
   
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBAction func loginButtonAction(sender: UIBarButtonItem) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword")
        
        signIn(self, email: userEmail, password: userPassword)
        var isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if isUserLoggedIn {
            backTwo()
        }
    }
    
    //Logar com o servidor
    
    func signIn(signInVC:SignInVC,email:String,password:String){
        
        let userNameEmail = email
        let userPassword = password
        
        
        if(userNameEmail.isEmpty || userPassword.isEmpty){
            signInVC.displayAlertMessage("É necessário preencher todos os campos.")
            return
        }
        
        //Enviar dados ao servidor
        let myUrl = NSURL(string: "http://smartpill.noip.me:8080/UsuariosWS/login")
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "email=\(userNameEmail)&pass=\(userPassword)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
                if(error != nil){
                    dispatch_async(dispatch_get_main_queue(), {
                        signInVC.displayAlertMessage("Problema ao tentar se conectar com o servidor, tente novamente mais tarde.")
                    });
                    return
                }
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if(json == nil){
                    dispatch_async(dispatch_get_main_queue(), {
                        signInVC.displayAlertMessage("Problema ao tentar se conectar com o servidor, tente novamente mais tarde ou confira seu e-mail e senha.")
                    });
                }else{
                    if let user = json{
                        var id = user["id"] as? Int
                        NSUserDefaults.standardUserDefaults().setInteger(id!, forKey: "userId")
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        print(json)
                    }
                }
        }
        
        task.resume()
    }

    
    func backTwo() {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers.first!, animated: true);
    }
    
    func displayAlertMessage(message:String){
        
        var myAlert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
}