//
//  NewMedicineVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 23/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class NewMedicineVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var activePrincipleTextField: UITextField!
    @IBOutlet weak var makerTextField: UITextField!
    @IBOutlet weak var presentationTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    var medicine:Medicine!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.med != nil{
            nameTextField.text = appDelegate.med!.name
            activePrincipleTextField.text = appDelegate.med!.activeIngredient
            makerTextField.text = appDelegate.med!.manufacturer
            presentationTextField.text = appDelegate.med!.availability
            quantityTextField.text = appDelegate.med!.quantity.stringValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonAction(sender: UIBarButtonItem) {
        if(!nameTextField.text.isEmpty && !activePrincipleTextField.text.isEmpty && !makerTextField.text.isEmpty && !presentationTextField.text.isEmpty && !quantityTextField.text.isEmpty){
            var med = Medicine.createMedicine(addActivePrinciple()!, availability: addPresentation()!, manufacturer: addMaker()!, name: addName()!, quantity: addQuantity()!, recipe: nil, reminder: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
           displayAlertMessage("Por favor, preencha todos os campos")
        }
    }
    
    @IBAction func cancelButtonAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func addName()->String?{
        if(!nameTextField.text.isEmpty){return nameTextField.text}
        return nil
    }
    func addActivePrinciple()->String?{
        if(!activePrincipleTextField.text.isEmpty){return activePrincipleTextField.text}
        return nil
    }
    func addMaker()->String?{
        if(!makerTextField.text.isEmpty){return makerTextField.text}
        return nil
    }
    func addPresentation()->String?{
        if(!presentationTextField.text.isEmpty){return presentationTextField.text}
        return nil
    }
    func addQuantity()->NSNumber?{
        if(!quantityTextField.text.isEmpty){
            var num = NSNumber(int:(quantityTextField.text as NSString).intValue)
            return num
        }
        return nil
    }
    
    func displayAlertMessage(message:String){
        
        var myAlert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
}
