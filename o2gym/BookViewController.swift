//
//  BookViewController.swift
//  o2gym
//
//  Created by xudongbo on 8/26/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    var coach:User!
    var budget:Int!
    let CALENDARHEIGHT:CGFloat = 35
    let CALENDARMENUHEIGHT:CGFloat = 30
    let TIMECOLLECTIONHEIGHT:CGFloat = 250
    var BOOKTABLEHEIGHT:CGFloat = 0
    
    var isCollapsed:Bool = false
    
    var dayBookedList:DayBookList!
    
    
    @IBOutlet weak var ConstraintCalendarMenuTop: NSLayoutConstraint!
    @IBOutlet var ConstraintCalendarTop: NSLayoutConstraint!
    
    @IBOutlet weak var tt: UIView!
    @IBOutlet weak var TimeCollectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var CalenderHeight: NSLayoutConstraint!
    @IBOutlet weak var CalendarMenuHeight: NSLayoutConstraint!
    @IBOutlet var BookedTableHeight: [NSLayoutConstraint]!
    
    @IBOutlet weak var BookedTable: UITableView!
    @IBOutlet weak var TimeCollectionView: UICollectionView!
    let TimeMap = ["09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30"]
    
    var bookedTime:[String:[Int]]! = [String:[Int]]()
    var naTime:[String:[Int]]! = [String:[Int]]()
    var restTime:[String:[Int]]! = [String:[Int]]()
    
    var dayBookedTime:[Int] = []
    var dayNaTime:[Int] = []
    var dayRestTime:[Int] = [0,1,2,3]
    
    var dayAvaTime:[Int] {
        get {
            return Array(0..<self.TimeMap.count).filter {
                (number)
                in
                if let index = find(self.dayRestTime, number) {
                    return false
                } else {
                    return true
                }
            }
            
        }
    }
    
    var curDate:CVDate!
    
    let MAXTIME:Int = 26
    
    
    @IBOutlet weak var Calendar: CVCalendarView!
    @IBOutlet weak var CalendarMenu: CVCalendarMenuView!
    
    var animationFinished = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BOOKTABLEHEIGHT = self.BookedTable.frame.size.height
        
        self.view.backgroundColor = O2Color.MainColor
        
        //self.Container.contentSize.height = 600
        
        self.TimeCollectionView.registerNib(UINib(nibName: "TimeTableCell", bundle: nil), forCellWithReuseIdentifier: "timetablecell")
        
        self.BookedTable.registerNib(UINib(nibName: "BookedCourseCell", bundle: nil), forCellReuseIdentifier: "bookedcoursecell")
        self.BookedTable.registerNib(UINib(nibName: "BookedCourseTitleCell", bundle: nil), forCellReuseIdentifier: "bookedcoursetitle")
        
        
        O2Nav.setController(self)
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = O2Color.MainColor
        self.navigationItem.leftBarButtonItems = [Helper.createBarButtonItemFromImg("back", selector: "back", tar: self)]
        
        //        self.navigationItem.rightBarButtonItems = [Helper.createBarButtonItemFromImg("back", selector: "collapse:", tar: self)]
        
        self.Calendar.calendarDelegate = self
        self.Calendar.calendarAppearanceDelegate = self
        self.CalendarMenu.menuViewDelegate = self
        self.curDate = CVDate(date: NSDate())
        self.title = self.curDate.globalDescription
        
        //self.title = "预约"
        // Do any additional setup after loading the view.
        self.CalendarMenu.backgroundColor = O2Color.MainColor
        
        
        self.TimeCollectionView.dataSource = self
        self.TimeCollectionView.delegate = self
        
        self.BookedTable.dataSource = self
        
        self.BookedTable.delegate = self
        self.view.bringSubviewToFront(self.tt)
        self.tt.bringSubviewToFront(self.BookedTable)
        
        self.reloadTimeCollectionView()
        
        
    }
    
    func reloadTimeCollectionView(){
        self.dayBookedList = DayBookList(name: self.coach.name!, date: self.curDate.numDescription)
        self.dayBookedList.load({ () -> Void in
            
            self.dayNaTime = []
            for b in self.dayBookedList.datalist {
                let hour = b as! Book
                self.dayNaTime.append(hour.hour)
                //每节课2小时，所以要增加1
                self.dayNaTime.append(hour.hour+1)
            }
            self.TimeCollectionView.reloadData()
            }, itemcallback: nil)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        Calendar.commitCalendarViewUpdate()
        CalendarMenu.commitMenuViewUpdate()
    }
    
    func saveBooks(){
        self.bookedTime[self.curDate.numDescription] = self.dayBookedTime
    }
    
    func back()
    {
        //O2Nav.setNavigationBarTransformProgress(0)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func collapse(gr:UITapGestureRecognizer){
        println(gr.view!.tag)
        if !self.isCollapsed {
            
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.ConstraintCalendarTop.constant = -60
                }, completion: { (_) -> Void in
                    UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                        self.BookedTable.frame = CGRectMake(
                            self.BookedTable.frame.origin.x,
                            0,
                            self.BookedTable.frame.size.width,
                            self.BOOKTABLEHEIGHT + self.CALENDARMENUHEIGHT  + self.CALENDARHEIGHT + self.TIMECOLLECTIONHEIGHT)
                        
                        gr.view!.transform = CGAffineTransformRotate(gr.view!.transform, CGFloat(M_PI) )
                        
                        }, completion: { (_) -> Void in
                    })
                    self.isCollapsed = true
            })
            
            
            
            
        }
        else {
            self.ConstraintCalendarTop.constant = -2
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.TimeCollectionView.frame.size.height = self.TIMECOLLECTIONHEIGHT
                self.BookedTable.frame = CGRectMake(
                    self.BookedTable.frame.origin.x,
                    self.TIMECOLLECTIONHEIGHT,
                    self.BookedTable.frame.size.width,
                    self.BOOKTABLEHEIGHT)
                gr.view!.transform = CGAffineTransformRotate(gr.view!.transform, CGFloat(M_PI) )
                }, completion: { (_) -> Void in
            })
            self.isCollapsed = false
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        O2Nav.setController(self)
        O2Nav.resetNav()
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

    
    func submitBooks(sender:UIButton){
        var i = 0
        for (day,hours) in self.bookedTime {
            self.submitBook(day, hour: hours[0], rowIndex: i, sender:sender)
            i++
        }
    }
    
    func submitBook(date:String,hour:Int, rowIndex:Int, sender:UIButton){
        let book = Book(date: date, hour: hour, coach: self.coach, customer: Local.USER)
        let cell = self.BookedTable.cellForRowAtIndexPath(NSIndexPath(forRow: rowIndex, inSection: 0)) as! BookedCourseCell
        
        cell.Indicator.startAnimating()
        cell.Indicator.hidden = false
        
        book.save({ (book) -> Void in
            println("save successful")

            cell.done()
            
            if rowIndex == (self.bookedTime.keys.array.count - 1) {
                let animation = CATransition()
                animation.type = kCATransitionFade
                animation.duration = 0.4;
                sender.layer.addAnimation(animation, forKey: nil)
                sender.hidden = true
                self.dayBookedTime = []
                self.bookedTime = [String:[Int]]()
                self.reloadTimeCollectionView()
                //self.BookedTable.reloadData()
            }
            //self.dayBookedTime = []

        }, error_handler: { (error) -> Void in
            println("save failed")
            println(error)
        })
        
        
    }
    
}
extension BookViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor{
        return O2Color.MainColor
    }
    
    func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
        //return O2Color.UpdateToast
        return O2Color.MainColor
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func dayLabelPresentWeekdayTextColor() -> UIColor{
        return UIColor.blackColor()
    }
    
    func dayLabelWeekdaySelectedTextColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    func dayLabelPresentWeekdaySelectedTextColor() -> UIColor{
        return UIColor.whiteColor()
    }
    
    
    
}

extension BookViewController: CVCalendarViewDelegate {
    func presentationMode() -> CalendarMode {
        return CalendarMode.WeekView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        self.curDate = date
        println("\(Calendar.presentedDate.commonDescription) is selected!")
        //TODO: load the day schedule
        self.dayBookedTime = []
        if let i = self.bookedTime.indexForKey(self.curDate.numDescription) {
            self.dayBookedTime = self.bookedTime[self.curDate.numDescription]!
        }
        
        self.reloadTimeCollectionView()
        //self.TimeCollectionView.reloadData()
        //self.refreshTime()
        
    }
    
    func didDeselectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        println("\(date.commonDescription) is deselected!")
    }
    
    func presentedDateUpdated(date: CVDate) {
        self.title = date.globalDescription
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        //        let day = dayView.date.day
        //        let randomDay = Int(arc4random_uniform(31))
        //        if day == randomDay {
        //            return true
        //        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        return [UIColor.clearColor()]
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
}


extension BookViewController: CVCalendarViewDelegate
{
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = O2Color.MainColor
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        //        if (dayView.isCurrentDay) {
        //            return true
        //        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = O2Color.MainColor
        
        var newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        var ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        //        if (Int(arc4random_uniform(3)) == 1)
        //        {
        //            return true
        //        }
        return false
    }
}


extension BookViewController: CVCalendarMenuViewDelegate {
    // firstWeekday() has been already implemented.
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    func dayOfWeekFont() -> UIFont {
        return UIFont(name: "RTWS YueGothic Trial", size: 14)!
    }
}


extension BookViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.TimeMap.count - self.dayRestTime.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("timetablecell", forIndexPath: indexPath) as! TimeTableCell
        cell.Time.tag = self.dayAvaTime[indexPath.row]
        cell.Time.text = self.TimeMap[dayAvaTime[indexPath.row]]
        cell.tappedcb = { (index) in
            //self.toggleCell(cell)
            if self.dayBookedTime.count != 0 && index == self.dayBookedTime[0] {
                self.dayBookedTime = []
                self.bookedTime.removeValueForKey(self.curDate.numDescription)
            } else {
                if nil == find(self.dayNaTime, index + 1) {
                    self.dayBookedTime = [index, index+1]
                    self.bookedTime[self.curDate.numDescription] = self.dayBookedTime
                }
            }
            self.BookedTable.reloadData()
            self.refreshTime()
        }
        
        
        if let i = find(self.dayAvaTime, cell.Time.tag) {
            cell.enableLabel()
        }
        
        if let i = find(self.dayNaTime, cell.Time.tag) {
            cell.disableLabel()
        }
        
        if indexPath.row == self.dayAvaTime.count-1 {
            cell.userInteractionEnabled = false 
        }
        
        if let i = find(self.dayBookedTime, cell.Time.tag) {
            cell.activeLabel()
        }
        
        return cell
    }
    func getCellByIndex(index:Int)->TimeTableCell{
        return self.TimeCollectionView.cellForItemAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! TimeTableCell
    }
    
    func refreshTime(){
        for i in 0..<self.dayAvaTime.count {
            let cell = self.getCellByIndex(i)
            cell.enableLabel()
        }
        for i in self.dayNaTime {
            if let index = find(self.dayAvaTime,i) {
                let cell = self.getCellByIndex(index)
                cell.disableLabel()
            }
        }
        //disable the last one
        self.getCellByIndex(self.dayAvaTime.count-1).userInteractionEnabled = false
        
        
        for i in self.dayBookedTime {
            if let index = find(self.dayAvaTime,i) {
                let cell = self.getCellByIndex(index)
                cell.activeLabel()
            }
        }
    }
}

extension BookViewController : UICollectionViewDelegate {
    
}

extension BookViewController : UITableViewDataSource{
    func refreshBooked(){
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookedTime.keys.array.count
        //return 10
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookedcoursecell", forIndexPath: indexPath) as! BookedCourseCell
        let day = self.bookedTime.keys.array.sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending } [indexPath.row]
        let time = self.TimeMap[self.bookedTime[day]![0]]
        cell.Day.text = day
        cell.Hour.text = time
        cell.Avatar.load(self.coach.avatar!, placeholder: UIImage(named: "avatar")){ (_, uiimg, errno_t) -> () in
            if uiimg != nil {
                cell.Avatar.image = Helper.RBSquareImage(uiimg!)
            }
        }
        cell.StatusImg.hidden = true
        //cell.CourseTitle.text = "xxxx"
        return cell
    }
}

extension BookViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookedcoursetitle") as! BookedCourseTitleCell
        let gr = UITapGestureRecognizer()
        gr.addTarget(self, action: "collapse:")

        cell.Arrow.addGestureRecognizer(gr)
        cell.bringSubviewToFront(cell.SubmitBtn)
        
        cell.SubmitBtn.addTarget(self, action: "submitBooks:", forControlEvents: UIControlEvents.TouchUpInside)

        
        if self.bookedTime.keys.array.count == 0 {
            cell.SubmitBtn.backgroundColor = UIColor.clearColor()
            cell.SubmitBtn.borderColor = O2Color.BorderGrey.colorWithAlphaComponent(0.8)
            //cell.SubmitBtn.tintColor = O2Color.TextGrey
            cell.SubmitBtn.setTitleColor(O2Color.BorderGrey.colorWithAlphaComponent(0.8), forState: UIControlState.Normal)
        }
        
        return cell
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
