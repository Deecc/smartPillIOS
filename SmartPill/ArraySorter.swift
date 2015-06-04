//
//  SPArraySorter.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 30/03/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

import UIKit

class ArraySorter: NSObject {

    
    func sortArray(array:[Reminder]) -> [Reminder]{

        let swiftArray = array
        let swiftArraySorted = swiftArray.sorted(sortReminders)

        return swiftArraySorted
    }
    
    func sortReminders(reminder1: Reminder, reminder2: Reminder) -> Bool {
        if  reminder1.medicine.name == reminder2.medicine.name {
            var date1 = reminder1.reminder_schedule.schedule
            date1 = deleteNSDateDay(date1)
            var date2 = reminder2.reminder_schedule.schedule
            date2 = deleteNSDateDay(date2)
            return sortNSDates(date1, day2: date2)
        }
        return reminder1.medicine.name < reminder2.medicine.name
    }
    
    func getRemindersLateTime(reminderArray:[Reminder])->[Reminder]{
        var newArray:[Reminder] = []
        for r in reminderArray{
            if remindersLateSorter(r) == nil {
                //do nothing
            }else{
                newArray.append(r)
            }
        }
        return newArray
    }
    
    func getRemindersEarlierTime(reminderArray:[Reminder])->[Reminder]{
        var newArray:[Reminder] = []
        for r in reminderArray{
            if remindersEarlierSorter(r) == nil {
                //do nothing
            }else{
                newArray.append(r)
            }
        }
        return newArray
    }
    
    
    func remindersLateSorter(reminder: Reminder)->Reminder?{
        var reminderDate = reminder.reminder_schedule.schedule
        reminderDate = deleteNSDateDay(reminderDate)
        var today = NSDate()
        today = deleteNSDateDay(today)
        if sortNSDates(reminderDate, day2: today){
            return reminder
        }else{
            return nil
        }
    }
    
    func remindersEarlierSorter(reminder: Reminder)->Reminder?{
        var reminderDate = reminder.reminder_schedule.schedule
        reminderDate = deleteNSDateDay(reminderDate)
        var today = NSDate()
        today = deleteNSDateDay(today)
        if sortNSDates(reminderDate, day2: today){
            return nil
        }else{
            return reminder
        }
    }
    
    func deleteNSDateDay(day:NSDate) -> NSDate{
        let flags: NSCalendarUnit = .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit
        let calendar = NSCalendar.currentCalendar()
        let componets:NSDateComponents = calendar.components(flags, fromDate: day)
        let timeOnly = calendar.dateFromComponents(componets)
        
        return timeOnly!
    }
    
    func sortNSDates(day1:NSDate, day2:NSDate) -> Bool {
        let day = day1.compare(day2)
        if day == .OrderedAscending {
            return true
        }
        else{
            return false
        }
    }
    
    
}
