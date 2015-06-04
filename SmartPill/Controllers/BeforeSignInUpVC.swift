//
//  beforeSignInUpVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class BeforeSignInUpVC: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(isUserLoggedIn){
           self.performSegueWithIdentifier("accountSegue", sender: nil)
        }
    }
    
    
}
