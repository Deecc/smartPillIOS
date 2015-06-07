//
//  AccountVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    
    
    @IBOutlet weak var InOutLabel: UIBarButtonItem!

    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    var containerVC: ContainerVC!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var status = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if status{
            InOutLabel.title = "Desconectar"
        }else{
            InOutLabel.title = "Conectar"
        }
    }
    
    
    @IBAction func segmentedValueChanged(sender: UISegmentedControl) {
        if(self.mySegmentedControl.titleForSegmentAtIndex(sender.selectedSegmentIndex) == "Histórico"){
            self.containerVC.swapToViewController("HistorySegue")
        }else if(self.mySegmentedControl.titleForSegmentAtIndex(sender.selectedSegmentIndex) == "Receitas"){
            self.containerVC.swapToViewController("RecipeSegue")
        }else if(self.mySegmentedControl.titleForSegmentAtIndex(sender.selectedSegmentIndex) == "Lembretes"){
            self.containerVC.swapToViewController("ReminderSegue")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "embedSegue"){
            self.containerVC = segue.destinationViewController as? ContainerVC
        }
    }
    
    @IBAction func logoutAction(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func logInLogOutButton(sender: UIBarButtonItem) {
        var status = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if status {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            InOutLabel.title = "Conectar"
        }else if !status {
            self.performSegueWithIdentifier("SignInUpSegue", sender: nil)
        }
    }
    
    
}
