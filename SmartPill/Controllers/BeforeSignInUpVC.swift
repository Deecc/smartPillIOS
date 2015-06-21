//
//  beforeSignInUpVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class BeforeSignInUpVC: UIViewController,FBSDKLoginButtonDelegate, GPPSignInDelegate  {
    
    //Facebook
    @IBOutlet weak var facebookButton: FBSDKLoginButton!
    //Google+
    @IBOutlet weak var googleButton: GPPSignInButton!
    var signIn : GPPSignIn!
    let clientId = "1017118379545-hf0f9jt0booe8c976nnvvaur86vlqpd1.apps.googleusercontent.com"
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var status = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if status {
            // User is already logged in SmartPill, do something here
        }
        self.googleButton.frame = CGRect(x: 16, y: 301, width: self.view.frame.width - 20, height: 34)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewDidLoadFacebook()
        viewDidLoadGoogle()
        
    }
    
}

