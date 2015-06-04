//
//  RecipeVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var recipes:[Recipe] = DatabaseGetter.getRecipes()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! UITableViewCell
        if (cell.viewWithTag(1) == nil){
            var cellDrawer = CellDrawer()
            cellDrawer.createWhiteContentInCell(cell)
            var stringNames = ""
            var medicines = recipes[indexPath.row].medicine.allObjects as! [Medicine]
            for m:Medicine in medicines{
                stringNames = stringNames + " " + m.name
            }
            cellDrawer.insertDescriptionLabel(cell, text: stringNames)
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(self.recipes.count > 0){return 1}
        else{return 0}
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de Receitas"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "RecipeDetailsSegue"){
            var recDetVC = segue.destinationViewController as! RecipeDetailsVC
            let indexPath = self.tableView.indexPathForSelectedRow()!
            recDetVC.recipe = recipes[indexPath.row]
        }
    }
    
    
    
}
