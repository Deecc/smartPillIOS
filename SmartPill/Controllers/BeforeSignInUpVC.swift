//
//  beforeSignInUpVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class BeforeSignInUpVC: UIViewController,FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var facebookButton: FBSDKLoginButton!
    
    override func viewWillAppear(animated: Bool) {
         weak var facebookButton: UIButton!
        super.viewWillAppear(animated)
        var status = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if status {
            //self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            self.facebookButton = loginView
            self.returnUserData()
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            self.facebookButton = loginView
        }
        
    }

    
}
