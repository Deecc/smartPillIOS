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
        
        if(userEmailStored == userEmail){
            if(userPasswordStored == userPassword){
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                backTwo()
            }
        }
    }
    func backTwo() {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers.first!, animated: true);
    }
    
}