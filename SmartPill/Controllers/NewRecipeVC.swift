//
//  NewRecipeVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 23/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class NewRecipeVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    var selectedMed:NSMutableArray = []
    @IBOutlet weak var noPictureLabel: UILabel!
    lazy var medicines:[Medicine] = {
        return DatabaseGetter.getMedicines()
        }()

    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            noPictureLabel.text = "Capturada"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomCell = self.tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! CustomCell
        if (cell.viewWithTag(1) == nil){
            cell.createWhiteContentInCell()
        }
        cell.name.text = medicines[indexPath.row].name
        cell.quantity.text = medicines[indexPath.row].quantity.stringValue
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(self.medicines.count > 0){return 1}
        else{return 0}
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Escolha os remédios dessa receita"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var med = medicines[indexPath.row]
        selectedMed.addObject(med)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var med = medicines[indexPath.row]
        selectedMed.removeObject(med)
    }
    
    @IBAction func saveButtonAction(sender: UIBarButtonItem) {
        if(selectedMed.count > 0 && imageView != nil){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                var imgData = UIImageJPEGRepresentation(self.imageView.image, 1.0)
                let recipe = Recipe.createRecipe(self.selectedMed, recipeImage: imgData)
                let restConnection = RestCon()
                restConnection.sendNewRecipeToServer(recipe!)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBAction func cancelButtonAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
