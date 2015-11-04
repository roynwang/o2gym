//
//  TrainCalendarController.swift
//  o2gym
//
//  Created by xudongbo on 10/30/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class TrainCalendarController: UIViewController {
    
    
    var usrname:String! = Local.USER.name!
    var book:Book!
    var trainHistory:TrainListByMonth!
    var isNew:Bool = false
    var name:String!
    
    
    var calendarMgr:JTCalendarManager!
    @IBOutlet weak var CalendarDays: JTHorizontalCalendarView!
    @IBOutlet weak var CalenderMenu: JTCalendarMenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "训练日历"
        
        self.calendarMgr = JTCalendarManager()
        self.calendarMgr.menuView = self.CalenderMenu
        
        self.calendarMgr.contentView = self.CalendarDays
        self.calendarMgr.delegate = self
        // Do any additional setup after loading the view.
        
        self.calendarMgr.setDate(NSDate())
        
        self.name = self.usrname
        if self.book != nil {
            self.name = self.book.customer.name!
        }
        
        
        self.trainHistory = TrainListByMonth(name: self.name, date: nil)
        self.trainHistory.load({ () -> Void in
            self.calendarMgr.reload()
            }, itemcallback: nil)

//        self.view.bringSubviewToFront(self.CalenderMenu)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //to avoid nil exception on iphone5
//        self.CalenderMenu.contentRatio = 1.5
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

extension TrainCalendarController:JTCalendarDelegate {
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if self.trainHistory == nil {
            return
        }
        var setted = false
        let day:JTCalendarDayView = dayView as! JTCalendarDayView
        for item in self.trainHistory.datalist {
            let train = item as! Train
            if train.date == day.date!.dateToString("yyyy-MM-dd") {
                day.circleView.hidden = false
                day.circleView.backgroundColor = O2Color.UpdateToast
                day.textLabel.textColor = UIColor.whiteColor()
                setted = true
            }
        }
        if self.calendarMgr.dateHelper.date(NSDate(), isTheSameDayThan: day.date!) {
            day.circleView.hidden = false
            day.circleView.backgroundColor = O2Color.LightMainColor
            day.textLabel.textColor = UIColor.whiteColor()
        }
        if !setted {
            day.circleView.hidden = true
            day.textLabel.textColor = UIColor.darkTextColor()
        }
        
        if !self.calendarMgr.dateHelper.date(self.CalendarDays.date, isTheSameMonthThan:day.date){
            day.textLabel.textColor = UIColor.lightGrayColor()
        }
        
//        if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
//            dayView.circleView.hidden = YES;
//            dayView.dotView.backgroundColor = [UIColor redColor];
//            dayView.textLabel.textColor = [UIColor lightGrayColor];
//        }

    }
    func calendarDidLoadNextPage(calendar: JTCalendarManager!) {
        let nexturl:NSString = self.trainHistory.nexturl!
        let nextmonth = nexturl.substringFromIndex(nexturl.length - 6)
        self.trainHistory = TrainListByMonth(name: self.name, date: nextmonth)
        self.trainHistory.load({ () -> Void in
             NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("reloadCalendar"), userInfo: nil, repeats: false)
            }, itemcallback: nil)
        
    }
    func reloadCalendar(){
        self.calendarMgr.reload()
    }
    func calendarDidLoadPreviousPage(calendar: JTCalendarManager!) {
        
        
        let prevurl:NSString = self.trainHistory.prevurl!
        let prevmonth = prevurl.substringFromIndex(prevurl.length - 6)
        
        self.trainHistory = TrainListByMonth(name: self.name, date: prevmonth)
        self.trainHistory.load({ () -> Void in
            
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("reloadCalendar"), userInfo: nil, repeats: false)
            
//            self.calendarMgr.reload()
            }, itemcallback: nil)
    }
    
    func calendar(calendar: JTCalendarManager!, prepareMenuItemView menuItemView: UIView!, date: NSDate!) {
        let menu = menuItemView as! UILabel
        menu.textColor = UIColor.whiteColor()
        menu.backgroundColor = O2Color.MainColor
        menu.borderColor = O2Color.MainColor
        menu.borderWidth = 1
        menu.text = date.dateToString("MMMM")
    }
    func calendarBuildWeekDayView(calendar: JTCalendarManager!) -> UIView! {
        
        let  view = JTCalendarWeekDayView()
        for item in view.dayViews {
            let label = item as! UILabel
            label.font = UIFont(name: "Avenir-Light", size: 15)
            label.textColor = UIColor.darkTextColor()
        }
        return view;
    }
    func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
        let day = dayView as! JTCalendarDayView
        
        var history:Train!
        
        for item in self.trainHistory.datalist {
            let train = item as! Train
            if train.date == day.date!.dateToString("yyyy-MM-dd") {
                history = train
            }
        }
       
        
        if day.circleView.hidden == false {
            let c = NewTrainningController()
            if self.book != nil {
                c.usrname = self.book.customer.name
                c.book = self.book
            } else {
                c.usrname = self.usrname
            }
            c.date = history.date.stringByReplacingOccurrencesOfString("-", withString: "")
            
            c.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(c, animated: true)
        }
    }
    
}
