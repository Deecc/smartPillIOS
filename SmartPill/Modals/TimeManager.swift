//
//  TimeManager.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

public class TimeManager: NSObject {
    public class func getStartDayHour() -> NSDate{
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let newDate = cal.startOfDayForDate(date)
        return newDate
    }
    //getEndDayHour()
    public class func getEndDayHour() -> NSDate{
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let newDate = cal.startOfDayForDate(date)
        let newDate1 = newDate.dateByAddingTimeInterval(60*60*24*1)
        return newDate1
    }
    public class func convertDateToInt(date:NSDate)-> Int{
        let calendar = NSCalendar.currentCalendar()
        let dateSlicer = calendar.components(.CalendarUnitMinute | .CalendarUnitHour | .CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear,fromDate: date)
        let year = dateSlicer.year
        let month = dateSlicer.month
        let day = dateSlicer.day
        let hour = dateSlicer.hour
        let minute = dateSlicer.minute
        
        let intDay = minute + hour*100 + day*10000 + month*1000000 + year*100000000
        
        return intDay
    }
}
