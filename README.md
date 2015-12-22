# SwiftCalendar
calendar with swift
用swift2实现的日历小控件
```
  calendarView = CalendarView(frame: CGRectMake(0, 30, SCREEN_WIDTH, 200))
  calendarView.dayRange = 0  //从今天的第几天开始可编辑
  calendarView.isShowOtherMonth = false //是否显示非本月号数
  calendarView.multiSelect = true //是否开启手势多选
  self.view.addSubview(calendarView)
  calendarView.dates = [NSDate(), Common.otherMonth(NSDate(), sum: 1), Common.otherMonth(NSDate(), sum: 2)]
```
demo如下

![image](https://github.com/suesu123456/SwiftCalendar/blob/master/demo.gif)
