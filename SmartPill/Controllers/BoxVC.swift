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
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var arrayReload = medicines
        print("vwa box remedios = \(arrayReload.count)\n")
        tableView.reloadData()
    }
    
    lazy var medicines:[Medicine] = {
        return DatabaseGetter.getMedicines()
    }()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! CustomCell
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
        return "Lista de Remédios"
    }
}
