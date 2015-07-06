//
//  TimeManager.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit

class TimeManager: NSObject {
    class func getStartDayHour() -> NSDate{
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let newDate = cal.startOfDayForDate(date)
        return newDate
    }
    //getEndDayHour()
    class func getEndDayHour() -> NSDate{
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let newDate = cal.startOfDayForDate(date)
        let newDate1 = newDate.dateByAddingTimeInterval(60*60*24*1)
        return newDate1
    }
}
