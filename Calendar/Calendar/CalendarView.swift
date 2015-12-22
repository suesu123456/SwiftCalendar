//
//  CalendarView.swift
//  Calendar
//
//  Created by sue on 15/12/17.
//  Copyright © 2015年 sue. All rights reserved.
//

import UIKit

class CalendarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dayRange: Int = 0 //从今天的第几天起可以点击
    var isShowOtherMonth: Bool = true //是否显示非本月
    var multiSelect: Bool = true //多选
    
    
    var collectionView: UICollectionView!
    var dates: [NSDate] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        
       
    }
    func initViews() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, frame.width, frame.height), collectionViewLayout: layout)
        collectionView.pagingEnabled = true
        collectionView.directionalLockEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.indicatorStyle = UIScrollViewIndicatorStyle.White
        collectionView.sizeToFit()
        self.collectionView!.registerClass(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        self.addSubview(collectionView!)
    
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! CalendarCell
        cell.dayRange = self.dayRange
        cell.isShowOtherMonth = self.isShowOtherMonth
        cell.multiSelect = self.multiSelect
        cell.setDates( dates[indexPath.row] )
       
        return cell
    }
    
}
