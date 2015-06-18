//
//  BeforeSignInUpVC + Facebook.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/06/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

extension BeforeSignInUpVC{
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
            self.returnUserData()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                let userName = result.valueForKey("name") as! String
                let userEmail = result.valueForKey("email") as! String
                let userId = result.valueForKey("id") as! String
                //DADOS COLETADOS, MANDAR PARA O SERVIDOR
            }
        })
    }
}