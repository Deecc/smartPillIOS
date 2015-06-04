//
//  ContainerVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    var currentSegueIdentifier:String!
    let firstIdentifier = "HistorySegue"
    let secondIdentifier = "RecipeSegue"
    let thirdIdentifier = "ReminderSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentSegueIdentifier = firstIdentifier
        self.performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == firstIdentifier){
            if(self.childViewControllers.count > 0){
                self.swapFromViewControllerTo(self.childViewControllers[0] as! UIViewController, toController: segue.destinationViewController as! UIViewController)
            }else{
                var controller:UIViewController = segue.destinationViewController as! UIViewController
                self.addChildViewController(controller)
                controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                self.view.addSubview(controller.view)
                controller.didMoveToParentViewController(self)
            }
        }else if(segue.identifier == secondIdentifier){
            self.swapFromViewControllerTo(self.childViewControllers[0] as! UIViewController, toController: segue.destinationViewController as! UIViewController)
        }else if(segue.identifier == thirdIdentifier){
             self.swapFromViewControllerTo(self.childViewControllers[0] as! UIViewController, toController: segue.destinationViewController as! UIViewController)
        }
    }
    
    func swapFromViewControllerTo(fromController:UIViewController,toController:UIViewController){
    
        toController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        fromController.willMoveToParentViewController(nil)
        self.addChildViewController(toController)
        self.transitionFromViewController(fromController, toViewController: toController, duration: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: nil,completion:{ finished in fromController.removeFromParentViewController()
            toController.didMoveToParentViewController(self)
        })
    }
    func swapToViewController(identifier:String){
        self.currentSegueIdentifier = identifier
        self.performSegueWithIdentifier(identifier, sender: nil)
    }
}
