//
//  BoxVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class BoxVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var medicines:[Medicine] = {
        return DatabaseGetter.getMedicines()
    }()!
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(self.medicines.count > 0){return 1}
        else{return 0}
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de Remédios"
    }
}
