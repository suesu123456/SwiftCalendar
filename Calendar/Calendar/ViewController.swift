//
//  ViewController.swift
//  Calendar
//
//  Created by sue on 15/12/17.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var calendarView: CalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initViews() {
        calendarView = CalendarView(frame: CGRectMake(0, 30, SCREEN_WIDTH, 200))
        calendarView.dayRange = 0
        calendarView.isShowOtherMonth = false
        calendarView.multiSelect = true
        self.view.addSubview(calendarView)
        calendarView.dates = [NSDate(), Common.otherMonth(NSDate(), sum: 1), Common.otherMonth(NSDate(), sum: 2)]
    }
}

