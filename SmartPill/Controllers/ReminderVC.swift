//
//  ReminderVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 17/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class ReminderVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var reminders:[Reminder] = DatabaseGetter.getReminders()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! CustomCell
        if (cell.viewWithTag(1) == nil){
            cell.createWhiteContentInCell()
        }
        cell.name.text = reminders[indexPath.row].medicine.name
        let schedule = reminders[indexPath.row].reminder_schedule.schedule
        let timeFormat = NSDateFormatter()
        timeFormat.dateFormat = "HH:MM"
        cell.time.text = timeFormat.stringFromDate(schedule)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(self.reminders.count > 0){return 1}
        else{return 0}
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de Lembretes"
    }
    
}
