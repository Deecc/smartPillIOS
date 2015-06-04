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
        
        //store data
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
        //display alert message with confirmation
        var myAlert = UIAlertController(title: "Alerta", message: "Registro realizado com sucesso", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
            self.performSegueWithIdentifier("accountSegueFromSignUp", sender: nil)
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    func displayAlertMessage(message:String){
    
        var myAlert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
}
