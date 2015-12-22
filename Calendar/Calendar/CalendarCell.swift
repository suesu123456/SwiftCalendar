//
//  CalendarCell.swift
//  Calendar
//
//  Created by sue on 15/12/18.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    var date: NSDate!
    
    var selectButton: UIButton = UIButton()
    var daysArray: [UIButton] = []
    var dayRange: Int = 0 //从今天的第几天起可以点击
    var isShowOtherMonth: Bool = true //是否显示非本月
    var multiSelect: Bool = true //多选
    
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    var itemW: CGFloat!
    var itemH: CGFloat!
    
    var headLabel = UILabel()
    var weekBg: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        self.backgroundColor = UIColor.whiteColor()       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func initViews() {
        for i in 0...41 {
            let button = UIButton()
            self.addSubview(button)
            daysArray.append(button)
        }
        //1. year month
        itemW = self.frame.size.width / 7
        itemH = self.frame.size.height / 8
        headLabel.font = UIFont.systemFontOfSize(14)
        headLabel.frame = CGRectMake(0, 0, self.frame.size.width, itemH)
        headLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(headLabel)
        //2.weekday
        let array = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        weekBg = UIView(frame: CGRectMake(0, headLabel.frame.maxY, self.frame.size.width, itemH))
        weekBg.backgroundColor = UIColor.orangeColor()
        self.addSubview(weekBg)
        
        for i in 0...6 {
            let week = UILabel()
            week.text = array[i]
            week.font = UIFont.systemFontOfSize(14)
            week.frame = CGRectMake(itemW * CGFloat(i), 0, itemW, 32)
            week.textAlignment = .Center
            week.backgroundColor = UIColor.clearColor()
            week.textColor = UIColor.whiteColor()
            weekBg.addSubview(week)
        }

    }
    
    // create View
    func setDates(date: NSDate) {
        self.date = date
        self.createCalendarViewWith(date)
    }
    func createCalendarViewWith(date: NSDate) {
        // year month
        headLabel.text = "\(self.year(date))年\(self.month(date))月"
        //3.days(1-31)
        for index in 0...41 {
            let x = CGFloat( index % 7 ) * itemW
            let y = CGFloat( index / 7 ) * itemH + weekBg.frame.maxY
            
            let dayButton = daysArray[index]
            dayButton.hidden = false
            dayButton.frame = CGRectMake(x, y, itemW, itemH)
            dayButton.titleLabel?.font = UIFont.systemFontOfSize(14)
            dayButton.titleLabel?.textAlignment = .Center
            dayButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            dayButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
            dayButton.addTarget(self, action: "logDate:", forControlEvents: .TouchUpInside)
            //添加本页滑动事件
            if multiSelect {
                let recognize = UIPanGestureRecognizer(target: self, action: "dragBtn:")
                dayButton.addGestureRecognizer(recognize)
            }
            
            let daysInLastMonth = self.totaldaysInMonth(Common.lastMonth(date))
            let daysInThisMonth = self.totaldaysInMonth(date)
            let firstWeekday = self.firstWeekdayInThisMonth(date)
            
            var day = 0
            
            if index < firstWeekday {
                day = daysInLastMonth - firstWeekday + index + 1
                if !self.isShowOtherMonth {
                    dayButton.hidden = true
                }
                self.setStyle_BeyondThisMonth(dayButton)
                
            }else if index > firstWeekday + daysInThisMonth - 1 {
                day = index + 1 - firstWeekday - daysInThisMonth
                if !self.isShowOtherMonth {
                    dayButton.hidden = true
                }
                self.setStyle_BeyondThisMonth(dayButton)
            }else{
                day = index - firstWeekday + 1
                self.setStyle_AfterToday(dayButton)
            }
            dayButton.setTitle("\(day)", forState: .Normal)
            //this month
            if self.month(date) == self.month(NSDate()) {
                let todayIndex = self.day(date) + firstWeekday - 1
                if index < todayIndex + self.dayRange && index >= firstWeekday {
                    self.setStyle_BeforeToday(dayButton)
                }else if index == todayIndex { //今天
                    //self.setStyle_Today(dayButton)
                }
            }
            
        }
    }
    //output date
    func logDate(dayBtn: UIButton) {
        
        selectButton = dayBtn
        self.setStyle_clickedButton(selectButton)
        let day = NSString(string:  dayBtn.titleForState(.Normal)!).integerValue
        let comp = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: self.date)
        print("\(day) -----\(comp.month) ---- \(comp.year)")
    }
    func dragBtn(sender: UIPanGestureRecognizer) {
        startPoint = (sender.view?.center)!
        endPoint = sender.locationInView(self)
        
        findSelectedDays()
        //起始点和结束点之间的控件都要变色
    }
    func findSelectedDays() {
        for i in 0...41 {
            var btn = self.daysArray[i]
            if !btn.hidden {
                if (btn.center.x >= startPoint.x && btn.center.y == startPoint.y) || (btn.center.x <= endPoint.x && btn.center.y <= endPoint.y && btn.center.y > startPoint.y) {
                    btn.backgroundColor = UIColor.orangeColor()
                    btn.selected = true
                }
            }
        }
    }
    // date button style
    func setStyle_BeyondThisMonth(btn: UIButton) {
        btn.enabled = false
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
    func setStyle_BeforeToday(btn: UIButton) {
        btn.enabled = false
        btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }
    func setStyle_Today(btn: UIButton) {
        btn.enabled = true
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Selected)
        btn.backgroundColor = UIColor.orangeColor()
    }
    func setStyle_AfterToday(btn: UIButton) {
        btn.enabled = true
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    func setStyle_clickedButton(btn: UIButton) {
        if btn.selected {
            btn.backgroundColor = UIColor.whiteColor()
            btn.selected = false
        }else{
            btn.backgroundColor = UIColor.orangeColor()
            btn.selected = true
        }
    }
    // date处理函数
    func day(date: NSDate) -> Int{
        let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: date)
        return components.day
    }
    func month(date: NSDate) -> Int{
        let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: date)
        return components.month
    }
    func year(date: NSDate) -> Int{
        let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: date)
        return components.year
    }
    func firstWeekdayInThisMonth(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        calendar.firstWeekday = 1 //1.Sun, 2.Mon ...
        let comp = calendar.components([.Year, .Month, .Day], fromDate: date)
        comp.day = 1
        let firstDayOfMonthDate: NSDate = calendar.dateFromComponents(comp)!
        let firstWeekday = calendar.ordinalityOfUnit(.Weekday, inUnit: .WeekOfMonth, forDate: firstDayOfMonthDate)
        return firstWeekday - 1
    }
    
    func totaldaysInMonth(date: NSDate) -> Int {
        let daysInOfMonth = NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: date)
        return daysInOfMonth.length
    }

}
