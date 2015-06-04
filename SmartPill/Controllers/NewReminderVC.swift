//
//  NewReminderVC.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 23/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class NewReminderVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var medicinePickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var medicine:Medicine!
    
    lazy var medicines:[Medicine] = {
        return DatabaseGetter.getMedicines()
        }()!
    lazy var currentSelectedMedicine:Medicine? = {
        var row = self.medicinePickerView.selectedRowInComponent(0)
        var name = self.medicineNamePicker[row]
        return DatabaseGetter.getMedicineWithName(name)
        }()
    lazy var selectedMedicine:String? = {
        return self.currentSelectedMedicine!.name
        }()
    lazy var medicineNamePicker:[String] = {
        var pickerList = [String]()
        for m in self.medicines{
            pickerList.append(m.name)
        }
        return pickerList
        }()
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.medicineNamePicker.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.medicineNamePicker[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedMedicine = self.medicineNamePicker[row]
    }
    
    func createReminderSchedule()->Reminder_Schedule{
        let schedule = Reminder_Schedule.createReminderSchedule(nil, date: self.datePicker.date)
        return schedule!
    }
    
    @IBAction func doneButtonAction(sender: UIBarButtonItem) {
        var reminder = Reminder.createReminder(DatabaseGetter.getMedicineWithName(self.selectedMedicine!), remSchedule: createReminderSchedule(), remSound: nil)
        setNotification()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func setNotification(){
        var medicineName = "\(self.currentSelectedMedicine!.name)"
        var dateString = "\(self.datePicker.date)"
        var userInfo = NSDictionary(objectsAndKeys: medicineName,"medicineName",dateString,"date")
        var localNotification = UILocalNotification()
        localNotification.userInfo = userInfo as! [String : String]
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = 1
        localNotification.repeatInterval = NSCalendarUnit.CalendarUnitDay
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

}
