//
//  SignUpVC.swift
//  Natal Urbano
//
//  Created by Dennis da Silva Nunes on 13/05/15.
//  Copyright (c) 2015 Phd Virtual. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController{

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userRepetedPWTextField: UITextField!
    
    @IBAction func registerButtonAction(sender: UIBarButtonItem) {
        
        let userName = userNameTextField.text
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepetedPassword = userRepetedPWTextField.text
        
        //Check for empty fields
        
        if(userName.isEmpty || userEmail.isEmpty || userPassword.isEmpty || userRepetedPassword.isEmpty){
        
            //display alert message
            displayAlertMessage("Por favor, preencha todos os campos")
            return
        }
        //Check if password matchs repeted password
        
        if(userPassword != userRepetedPassword){
        
            //display alert message
            displayAlertMessage("Os campos de senha não estão iguais")
            return
        }
        
        //display alert message with confirmation
        signUp(self)
        var isUserLogged = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if isUserLogged {
            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
            NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
            NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
            NSUserDefaults.standardUserDefaults().synchronize()
            var myAlert = UIAlertController(title: "Alerta", message: "Registro realizado com sucesso", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                self.backTwo()
            }
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    }
    
    func displayAlertMessage(message:String){
    
        var myAlert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    func backTwo() {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers.first!, animated: true);
    }
    
    //Cadastra com o servidor e loga depois
    func signUp(signUpVC:SignUpVC) -> Bool{
        
        let userName = signUpVC.userNameTextField.text
        let userEmail = signUpVC.userEmailTextField.text
        let userPassword = signUpVC.userPasswordTextField.text
        
        //Enviar dados ao servidor
        let myUrl = NSURL(string: "http://smartpill.noip.me:8080/UsuariosWS/setUser")
            //?email=%40&name=%40&pass
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "email=\(userEmail)&name=\(userName)&pass=\(userPassword)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            { data,response,error in
            
                if(error != nil){
                    dispatch_async(dispatch_get_main_queue(), {
                        signUpVC.displayAlertMessage("Problema ao tentar se conectar com o servidor, tente novamente mais tarde.")
                    });
                    return
                }
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if(data == nil){
                    dispatch_async(dispatch_get_main_queue(), {
                        signUpVC.displayAlertMessage("Problema ao tentar se conectar com o servidor, tente novamente mais tarde.")
                    });
                    return
                }else{
                    if let user = json{
                        if let id = user["id"] as? Int {
                            NSUserDefaults.standardUserDefaults().setInteger(id, forKey: "userId")
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                            NSUserDefaults.standardUserDefaults().synchronize()
                        }else{
                            dispatch_async(dispatch_get_main_queue(), {
                                signUpVC.displayAlertMessage("Problema ao tentar se conectar com o servidor, email existente.")
                            });
                        }
                    }else{
                        dispatch_async(dispatch_get_main_queue(), {
                            signUpVC.displayAlertMessage("Problema ao tentar se conectar com o servidor,tente novamente mais tarde.")
                        });
                    }
                    return
                }
        }
        task.resume()
        return true
    }
}
