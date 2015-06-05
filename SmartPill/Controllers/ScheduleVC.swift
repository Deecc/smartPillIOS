//
//  ScheduleVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 16/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getDataToArrays()
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var allRemSorted:[Reminder]!
    var remindersTaken: [Reminder] = []
    var remindersPastTime: [Reminder]!
    var remindersToBeTaken: [Reminder]!
    
    
    func getDataToArrays(){
        var arrSorter = ArraySorter()
        allRemSorted = DatabaseGetter.getReminders()
        allRemSorted = arrSorter.sortArray(allRemSorted!)
        remindersPastTime = arrSorter.getRemindersLateTime(self.allRemSorted)
        remindersToBeTaken = arrSorter.getRemindersEarlierTime(self.allRemSorted)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as! CustomCell
        var arr:[Reminder]!
        if (indexPath.section == 0){
            arr = remindersPastTime
        }else if (indexPath.section == 1){
            arr = remindersToBeTaken
        }else {
            arr = remindersTaken
        }
        if (cell.viewWithTag(1) == nil){
            cell.createWhiteContentInCell()
        }
        cell.name.text = arr[indexPath.row].medicine.name
        var date = arr[indexPath.row].reminder_schedule.schedule
        let timeFormat = NSDateFormatter()
        timeFormat.dateFormat = "HH:MM"
        let dateTimePrefix = timeFormat.stringFromDate(date)
        cell.time.text = dateTimePrefix
        cell.quantity.text = arr[indexPath.row].medicine.quantity.stringValue
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){return remindersPastTime!.count}
        else if(section == 1){return remindersToBeTaken!.count}
        else{return remindersTaken.count}
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(self.allRemSorted.count > 0){return 3}
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0 && remindersPastTime.count>0){
            return "Remédios atrasados"
        }else if(section == 1 && remindersToBeTaken.count>0){
            return "Remédios à tomar"
        }else if(section == 2 && remindersTaken.count>0){
            return "Remédios tomados"
        }else{
            return ""
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0){
            let reminder = remindersPastTime[indexPath.row]
            if let foundIndex = find(remindersPastTime, reminder) {
                remindersPastTime.removeAtIndex(foundIndex)
            }
            remindersTaken.append(reminder)
        }else if(indexPath.section == 1){
            let reminder = remindersToBeTaken[indexPath.row]
            if let foundIndex = find(remindersToBeTaken, reminder) {
                remindersToBeTaken.removeAtIndex(foundIndex)
            }
            remindersTaken.append(reminder)
        }else if(indexPath.section == 2){
            let reminder = remindersTaken[indexPath.row]
            let arrSorter = ArraySorter()
            if arrSorter.remindersEarlierSorter(reminder) != nil {
                remindersToBeTaken.append(reminder)
            }else if arrSorter.remindersLateSorter(reminder) != nil{
                remindersPastTime.append(reminder)
            }
            if let foundIndex = find(remindersTaken, reminder) {
                remindersTaken.removeAtIndex(foundIndex)
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func displayActionSheetDelegate(sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Adicionar", message: nil, preferredStyle: .ActionSheet)
        //Creating actions
        let medicineAction = UIAlertAction(title: "Remédios", style: .Default){action in
            let newMedicineVC = self.storyboard?.instantiateViewControllerWithIdentifier("newmedicine") as! NewMedicineVC
            self.presentViewController(newMedicineVC, animated: true, completion: nil)
        }
        let ReminderAction = UIAlertAction(title: "Lembretes", style: .Default){action in
            let newReminderVC = self.storyboard?.instantiateViewControllerWithIdentifier("newreminder") as! NewReminderVC
            self.presentViewController(newReminderVC, animated: true, completion: nil)
        }
        let recipeAction = UIAlertAction(title: "Receitas", style: .Default){action in
            let newRecipeVC = self.storyboard?.instantiateViewControllerWithIdentifier("newrecipe") as! NewRecipeVC
            self.presentViewController(newRecipeVC, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel,handler: nil)
        //Adding actions to the sheet
        actionSheet.addAction(medicineAction)
        actionSheet.addAction(ReminderAction)
        actionSheet.addAction(recipeAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true,completion: nil)
    }

}
