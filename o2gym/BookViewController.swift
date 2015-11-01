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
    var product:Product!
    var order:OrderItem!
    var budget:Int = 3
    
    var isSingleBook = false
    
    let CALENDARHEIGHT:CGFloat = 35
    let CALENDARMENUHEIGHT:CGFloat = 30
    var TIMECOLLECTIONHEIGHT:CGFloat = 280
    var BOOKTABLEHEIGHT:CGFloat = 0
    
    var isCollapsed:Bool = false
    var dayBookedList:DayBookList!
    var startDay:NSDate!
    var BookedTableHeader:BookedCourseTitleCell!
    
    
    @IBOutlet weak var ConstraintCalendarMenuTop: NSLayoutConstraint!
    @IBOutlet var ConstraintCalendarTop: NSLayoutConstraint!
    
    @IBOutlet weak var tt: UIView!
    @IBOutlet weak var TimeCollectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var CalenderHeight: NSLayoutConstraint!
    @IBOutlet weak var CalendarMenuHeight: NSLayoutConstraint!
    @IBOutlet var BookedTableHeight: [NSLayoutConstraint]!
    
    @IBOutlet weak var BookedTable: UITableView!
    @IBOutlet weak var TimeCollectionView: UICollectionView!
    //    let TimeMap = ["09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30"]
    
    var bookedTime:[String:[Int]]! = [String:[Int]]()
    var naTime:[String:[Int]]! = [String:[Int]]()
    var restTime:[String:[Int]]! = [String:[Int]]()
    
    var dayBookedTime:[Int] = []
    var dayTime:DayTime!
    
    
    var curDate:CVDate!
    
    
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
        
        //loading the booked item of the order
        
        
        //self.reloadTimeCollectionView()
    }
    //
    func orderToBookedTime(){
        self.bookedTime = [String:[Int]]()
        for book in self.order.booked {
            let key = book.date.stringByReplacingOccurrencesOfString("-", withString: "/")
            let value:[Int] = [book.hour,book.hour + 1]
            self.bookedTime[key] = value
            
        }
        
    }
    
    
    
    func reloadTimeCollectionView(){
        self.dayTime = DayTime(name: self.coach.name!, date: self.curDate.numDescription)
        self.dayTime.loadRemote({ (_) -> Void in
            //update height
            var allshowntime:[Int] = []
            for h in 0..<Local.TimeMap.count-1 {
                if  nil == self.dayTime.out.indexOf(h) {
                    allshowntime.append(h)
                }
            }
            // remove booked time form na
            if let v = self.bookedTime[self.dayTime.date] {
                self.dayTime.na = self.dayTime.na.filter({ nil == v.indexOf($0)})
                self.dayBookedTime = v
            }
            
            for book in self.order.booked{
                if book.date == self.dayTime.date {
                    if let i = self.dayTime.na.indexOf(book.hour){
                        self.dayTime.na.removeAtIndex(i)
                    }
                    if let i = self.dayTime.na.indexOf(book.hour+1){
                        self.dayTime.na.removeAtIndex(i)
                    }
                }
            }
            
            
            print(self.dayTime.na)
            self.TimeCollectionView.reloadData()
            }, onfail: nil)
        
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
        print(gr.view!.tag)
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
        self.bookedTime = [String:[Int]]()
        if self.isSingleBook {
            self.budget = 1
            self.orderToBookedTime()
            
            if self.product != nil {
                
                self.coach = self.product.coach!
                self.reloadTimeCollectionView()
                self.BookedTable.reloadData()
                self.order = OrderItem(product: self.product, customer: Local.USER)
                
            } else {
            
            
            self.product = Product(productid: self.order.product!)
            self.product.loadRemote({ (_) -> Void in
                //self.budget = self.product.amount
                self.coach = self.product.coach!
                self.reloadTimeCollectionView()
                self.BookedTable.reloadData()
                }, onfail: { (_) -> Void in
                    self.back()
            })
            }
            
        } else {
            if self.product != nil {
                self.budget = self.product.amount
                self.coach = self.product.coach!
                self.reloadTimeCollectionView()
                self.BookedTable.reloadData()
                self.order = OrderItem(product: self.product, customer: Local.USER)
            } else {
            self.order.name = Local.USER.name
            self.order.loadRemote({ (_) -> Void in
                self.orderToBookedTime()
                self.product = Product(productid: self.order.product!)
                self.product.loadRemote({ (_) -> Void in
                    self.budget = self.product.amount
                    self.coach = self.product.coach!
                    self.reloadTimeCollectionView()
                    self.BookedTable.reloadData()
                    }, onfail: { (_) -> Void in
                        self.back()
                })
                
                }, onfail: nil)
        }
        }
        //

    }
    
    override func viewDidAppear(animated: Bool) {
        if self.startDay != nil {
            self.Calendar.toggleViewWithDate(self.startDay)
        }
        self.setBugetLabelText()
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    func saveAllBook(sender:UIButton) {
        var i = 0
        //delete old
        for book in self.order.booked {
            var existed = false
            for (day,hours) in self.bookedTime {
                if book.date == day &&
                    book.hour == hours[0] {
                        existed = true
                        break
                }
            }
            if !existed {
                book.delete(nil, onfail: nil)
            }
        }
        
        let sortedday = self.bookedTime.keys.sort{ $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
        for day in sortedday  {
            var hours:[Int] = self.bookedTime[day]!
            var existed = false
            //if not in self.order.booked then add
            for book in self.order.booked {
                if book.date == day && book.hour == hours[0] {
                    existed = true
                    break
                }
            }
            if !existed {
                self.submitBook(day, hour: hours[0], rowIndex: i, sender:sender)
            }
            i++
            
        }
    }
    
    
    func submitBooks(sender:UIButton){
        
        //payAlert.addButtonWithTitle(<#T##title: String!##String!#>, type: <#T##SIAlertViewButtonType#>)
        
        if self.order.billid == nil {
            self.view.makeToastActivity(position: HRToastPositionCenter, message: "订单创建中")
            self.order.save({ (_) -> Void in
                self.saveAllBook(sender)
                self.view.hideToastActivity()
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let cont =  sb.instantiateViewControllerWithIdentifier("orderdetail") as! OrderDetailListController
                cont.order = self.order
                cont.backtwice = true
                self.navigationController?.pushViewController(cont, animated: true)
                //self.showPay()
                }, error_handler: {
                    (error) in
                    self.view.makeToast(message: "订单创建失败")
            })
        } else {
            self.saveAllBook(sender)
            self.view.makeToast(message: "预约已提交",duration:1, position:HRToastPositionCenter)
            let delay = 1.0 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
        
    }
    
    func showPay(){
        if self.order.status == "unpaid" {
            
            let payAlert = SIAlertView(title: "支付", andMessage: "预约已提交，请在30分钟内支付。您也可以在 我->我的订单 处支付及预约剩余课程")
            
            payAlert.addButtonWithTitle("支付", type: SIAlertViewButtonType.Default, handler: { (alert) -> Void in
                
              
    
                self.order.pay({ () -> Void in
                    self.view.hideToastActivity()
                    self.view.makeToast(message: "支付成功", duration: 2, position: HRToastPositionCenter)
                    
                    let delay = 2.0 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                    }, onFail:{()-> Void
                        in
                        self.view.hideToastActivity()
                        let payFail = SIAlertView(title: "支付失败", andMessage: "支付没成功？您也可以稍后在 我->我的订单 处重新支付")
                        payFail.addButtonWithTitle("关闭",type: SIAlertViewButtonType.Default, handler:nil)
                        payFail.show()
                })
            })
            payAlert.addButtonWithTitle("取消", type: SIAlertViewButtonType.Cancel, handler: nil)
            
            payAlert.show()
            
        } else {
            self.view.makeToast(message: "预约已提交")
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    func submitBook(date:String,hour:Int, rowIndex:Int, sender:UIButton){
        let book = Book(date: date, hour: hour, coach: self.coach, customer: self.order.customer, orderid: self.order.id)
        
        
        let cell = self.BookedTable.cellForRowAtIndexPath(NSIndexPath(forRow: rowIndex, inSection: 0)) as! BookedCourseCell
        
        cell.Indicator.startAnimating()
        cell.Indicator.hidden = false
        cell.DelBtn.hidden = true
        
        
        book.save({ (book) -> Void in
            print("save successful")
            cell.done()

            if rowIndex == (self.bookedTime.keys.count - 1) {
                let animation = CATransition()
                animation.type = kCATransitionFade
                animation.duration = 0.4;
                sender.layer.addAnimation(animation, forKey: nil)
                sender.hidden = true
                self.dayBookedTime = []
                
                //TODO
                //show oder detail
            
            }
            //self.dayBookedTime = []
            
            }, error_handler: { (error) -> Void in
                self.view.makeToast(message: error)
                
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
        print("\(Calendar.presentedDate.commonDescription) is selected!")
        //TODO: load the day schedule
        self.dayBookedTime = []
        if let _ = self.bookedTime.indexForKey(self.curDate.numDescription) {
            self.dayBookedTime = self.bookedTime[self.curDate.numDescription]!
        }
        
        self.reloadTimeCollectionView()
        
        
        if self.bookedTime.count >= self.budget
            &&  self.dayBookedTime.count == 0 {
                self.TimeCollectionView.userInteractionEnabled = false
        } else {
            self.TimeCollectionView.userInteractionEnabled = true
        }
        
    }
    
    func didDeselectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        print("\(date.commonDescription) is deselected!")
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


extension BookViewController
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
        
        let newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
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
        if self.dayTime == nil {
            return 0
        }
        return Local.TimeMap.count - 1 - self.dayTime.out.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        var allshowntime:[Int] = []
        for h in 0..<Local.TimeMap.count - 1 {
            if  nil == self.dayTime.out.indexOf(h) {
                allshowntime.append(h)
            }
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("timetablecell", forIndexPath: indexPath) as! TimeTableCell
        
        cell.Time.tag = allshowntime[indexPath.row]
        cell.Time.text = Local.TimeMap[allshowntime[indexPath.row]]
        cell.tappedcb = { (index) in
            //self.toggleCell(cell)
            if self.dayBookedTime.count != 0 && index == self.dayBookedTime[0] {
                self.dayBookedTime = []
                self.bookedTime.removeValueForKey(self.curDate.numDescription)
            } else {
                if nil == self.dayTime.na.indexOf(index + 1) {
                    self.dayBookedTime = [index, index+1]
                    self.bookedTime[self.curDate.numDescription] = self.dayBookedTime
                } else {
                    return
                }
            }
            self.BookedTable.reloadData()
            self.refreshTime()
            self.setBugetLabelText()
        }
        cell.userInteractionEnabled = true
        cell.Time.userInteractionEnabled = true
        
        if let _ = self.dayTime.noon.indexOf(cell.Time.tag){
            cell.Time.text = "午休"
        }
        
        if let _ = allshowntime.indexOf(cell.Time.tag) {
            cell.enableLabel()
        }
        
        if let _ = self.dayTime.na.indexOf(cell.Time.tag) {
            cell.disableLabel()
        }
        
        if let _ = self.dayBookedTime.indexOf(cell.Time.tag) {
            cell.activeLabel()
        }
        for book in self.order.booked {
            if self.curDate.numDescription == book.date &&
                (book.hour == cell.Time.tag || book.hour+1 == cell.Time.tag ){
                    cell.enableLabel()
                    if let _ = self.dayBookedTime.indexOf(cell.Time.tag) {
                        cell.activeLabel()
                    }
                    cell.userInteractionEnabled = !book.done
            }
        }
        if indexPath.row == collectionView.numberOfItemsInSection(0) - 1  {
            cell.userInteractionEnabled = false
        }
        
        
        return cell
    }
    func getCellByIndex(index:Int)->TimeTableCell?{
        if let lastone = self.TimeCollectionView.cellForItemAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) {
            return  lastone as? TimeTableCell
        }
        return nil
    }
    
    func refreshTime(){
        var allshowntime:[Int] = []
        for h in 0..<Local.TimeMap.count - 1 {
            if  nil == self.dayTime.out.indexOf(h) {
                allshowntime.append(h)
            }
        }
        for i in 0..<self.TimeCollectionView.numberOfItemsInSection(0){
            //for i in 0..<self.dayAvaTime.count {
            if let cell = self.getCellByIndex(i) {
                cell.enableLabel()
            }
        }
        for i in self.dayTime.na {
            //for i in self.dayNaTime {
            if let index = allshowntime.indexOf(i) {
                if let cell = self.getCellByIndex(index) {
                    cell.disableLabel()
                }
            }
        }
        //disable the last one
        if let lastone = self.getCellByIndex(self.TimeCollectionView.numberOfItemsInSection(0)-1) {
            lastone.userInteractionEnabled = false
        }
        
        
        for i in self.dayBookedTime {
            if let index = allshowntime.indexOf(i) {
                if let cell = self.getCellByIndex(index) {
                    cell.activeLabel()
                }
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
        if self.coach == nil {
            return 0
        }
        return self.bookedTime.keys.count
        //return 10
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookedcoursecell", forIndexPath: indexPath) as! BookedCourseCell
        let day = self.bookedTime.keys.sort { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending } [indexPath.row]
        let time = Local.TimeMap[self.bookedTime[day]![0]]
        cell.Day.text = day
        cell.Hour.text = time
        cell.Avatar.fitLoad(self.coach.avatar!, placeholder: UIImage(named: "avatar"))
        
        cell.StatusImg.hidden = true
        cell.DelBtn.hidden = false
        
        for book in self.order.booked {
            print(book.done)
            print(book.date.stringByReplacingOccurrencesOfString("-", withString: "/") == day)
            print(book.hour == self.bookedTime[day]![0])
            if book.done &&
                book.date.stringByReplacingOccurrencesOfString("-", withString: "/") == day &&
                book.hour == self.bookedTime[day]![0] {
                    cell.DelBtn.hidden = true
            }
        }
        
        
        //cell.CourseTitle.text = "xxxx"
        cell.delcallback = {
            () in
            self.bookedTime.removeValueForKey(day)
            self.dayBookedTime = self.bookedTime[self.curDate.numDescription] ?? [Int]()
            self.BookedTable.reloadData()
            self.TimeCollectionView.reloadData()
        }
        
        
        return cell
    }
    
    //TODY: why this doesn't work????
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
}

extension BookViewController : UITableViewDelegate {
    func setBugetLabelText(){
        //self.BookedTableHeader.BudgetLabel.text = "已选择 \(self.bookedTime.count.toString())/\(self.budget)"
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookedcoursetitle") as! BookedCourseTitleCell
        let gr = UITapGestureRecognizer()
        gr.addTarget(self, action: "collapse:")
        
        cell.Arrow.addGestureRecognizer(gr)
        cell.bringSubviewToFront(cell.SubmitBtn)
        
        cell.SubmitBtn.addTarget(self, action: "submitBooks:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.SubmitBtn.userInteractionEnabled = true
        if self.bookedTime.keys.count == 0 {
            cell.SubmitBtn.backgroundColor = UIColor.clearColor()
            cell.SubmitBtn.borderColor = O2Color.BorderGrey.colorWithAlphaComponent(0.8)
            //cell.SubmitBtn.tintColor = O2Color.TextGrey
            cell.SubmitBtn.setTitleColor(O2Color.BorderGrey.colorWithAlphaComponent(0.8), forState: UIControlState.Normal)
            cell.SubmitBtn.userInteractionEnabled = false
        }
        self.BookedTableHeader = cell
        cell.BudgetLabel.text = "已选择 \(self.bookedTime.count.toString())/\(self.budget)"
        return cell
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}
