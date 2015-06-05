//
//  RecipeDetailsVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 04/06/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class RecipeDetailsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var recipe:Recipe!
    var medicines:[Medicine]!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        imageView.image = UIImage(data: recipe.recipeImage)
        medicines = recipe.medicine.allObjects as! [Medicine]
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.medicine.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Remédios da Receita"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! CustomCell
      
        if (cell.viewWithTag(1) == nil){
            cell.createWhiteContentInCell()
        }
        cell.name.text = medicines[indexPath.row].name
        
        return cell
    }
    
    
}
