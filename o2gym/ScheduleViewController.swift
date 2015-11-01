//
//  ScheduleViewController.swift
//  o2gym
//
//  Created by xudongbo on 8/30/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {
    var curDate:CVDate!
    var weekSchedule:WeekBookList!
    var daylist:[String : [Book]]!
    var days:[String]!
    
    var executing:Bool?
    
    
    //    var refreshcontrol : UIRefreshControl!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(style: UITableViewStyle.Grouped)
        
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        //super.init(nibName, bundle: nibBundleOrNil)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.days = []
        self.navigationController?.navigationController?.navigationBar.translucent = false
        self.curDate = CVDate(date: NSDate())
        self.tableView.registerNib(UINib(nibName: "BookedCourseComplexCell", bundle: nil), forCellReuseIdentifier: "bookedcoursecell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //        self.tableView.estimatedRowHeight = 100
        //        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 140
        self.tableView.separatorColor = O2Color.BorderGrey
        self.tableView.sectionIndexColor = O2Color.TextGrey
        
        
        self.tableView.backgroundColor = O2Color.BgGreyColor
        
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl!.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        
        
       
        
        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        
        self.refreshControl?.beginRefreshing()
        
        Local.SCHEDULE = WeekBookList(name: Local.USER.name!, date: self.curDate.numDescription)
        self.weekSchedule = Local.SCHEDULE
        self.executing = true
        
        let endelay = 0.3 * Double(NSEC_PER_SEC)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(endelay)), dispatch_get_main_queue(), {
            self.refreshControl?.endRefreshing()
        })

        
        dispatch_async(dispatch_get_main_queue()){
            self.weekSchedule.load({ () -> Void in
                self.processSchedule()
   
               
                self.executing = false
                let delay = 0.3 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
              
                }, itemcallback: nil)
            
        }
        
        
        //        self.weekSchedule = Local.SCHEDULE
        //
        //        self.weekSchedule.load({ () -> Void in
        //            self.processSchedule()
        //            self.tableView.reloadData()
        //            //            self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新", attributes: [NSFontAttributeName: UIFont(name: "Avenir", size: 12)!, NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        //            }, itemcallback: nil)
        
    }
    
    func processSchedule(){
        self.days = []
        print("load week done")
        self.daylist = [String:[Book]]()
        for item in self.weekSchedule.datalist {
            let book = item as! Book
            if nil == self.daylist.keys.indexOf(book.date) {
                self.daylist[book.date] = [book]
                self.days.append(book.date)
            } else {
                self.daylist![book.date]?.append(book)
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if self.daylist == nil {
            return 0
        }
        return self.daylist.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section
        if self.daylist == nil {
            return 0
        }
        if self.weekSchedule == nil {
            return 0
        } else {
            return self.daylist[self.days[section]]!.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookedcoursecell", forIndexPath: indexPath) as! BookedCourseComplexCell
        if  indexPath.row < self.daylist[self.days[indexPath.section]]?.count {
            let book = self.daylist[self.days[indexPath.section]]![indexPath.row]
            cell.setByBook(book)
        }
        // Configure the cell...
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.daylist == nil {
            return "Failed"
        }
        return self.days[section]
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        
        header.textLabel!.font = UIFont(name: "Avenir", size: 18)
        //header.textLabel.text = self.daylist.keys.array[section]
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        return 25
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let book = self.daylist[self.days[indexPath.section]]![indexPath.row]
        
        if !book.done {
            return
        }
        
        let cont = NewTrainningController()
        cont.book = book
        cont.usrname = cont.book.customer.name!
        cont.date = book.date.stringByReplacingOccurrencesOfString("/", withString: "")
        self.navigationController?.pushViewController(cont, animated: true)
        
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {
            self.loadOld()
        }
    }
    
    func loadOld() {
        if self.executing == nil || self.executing == true {
            return
        }
        self.executing = true
        func addlatest(){
            self.executing = false
            if self.weekSchedule.delta == 0 {
                //                self.nomore = true
                return
            }
            self.processSchedule()
            self.tableView.reloadData()
            
            //self.showUpdateToast(self.feed.delta)
        }
        self.weekSchedule.loadHistory(addlatest, itemcallback: nil)
    }
    
    
    func refresh(){
        
        if self.executing == nil {
            return
        }
        
        if self.executing == true {
            self.refreshControl?.endRefreshing()
            return
        }
        self.executing = true
        self.weekSchedule.loadLate({ () -> Void in
            self.executing = false
            self.processSchedule()
            self.refreshControl?.endRefreshing()
            let delay = 0.3 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
            }, itemcallback: nil)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    
}
