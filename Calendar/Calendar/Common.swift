//
//  Common.swift
//  Calendar
//
//  Created by sue on 15/12/18.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

let SCREEN_WIDTH: CGFloat = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.size.height

class Common: NSObject {
    static func lastMonth(date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = -1
        let newDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: date, options: NSCalendarOptions.WrapComponents)
        return newDate!
    }
    static func nextMonth(date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = +1
        let newDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: date, options: NSCalendarOptions.WrapComponents)
        return newDate!
    }
    static func otherMonth(date: NSDate, sum: Int) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = +sum
        let newDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: date, options: NSCalendarOptions.WrapComponents)
        return newDate!
    }
}
