//
//  beforeSignInUpVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class BeforeSignInUpVC: UIViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var status = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if status {
            //self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
