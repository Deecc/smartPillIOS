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
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! UITableViewCell
        var cellDrawer = CellDrawer()
        if (cell.viewWithTag(1) == nil){
            cellDrawer.createWhiteContentInCell(cell)
        }
        cellDrawer.insertDescriptionLabel(cell, text: medicines[indexPath.row].name)
        let num = medicines[indexPath.row].quantity
        let stringNum = num.stringValue
        cellDrawer.insertQuantityLabelInVCenter(cell, text: stringNum)
        return cell
    }
    
    
}
