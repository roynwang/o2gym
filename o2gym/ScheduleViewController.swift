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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.days = []
        self.navigationController?.navigationController?.navigationBar.translucent = false
        self.curDate = CVDate(date: NSDate())
        self.tableView.registerNib(UINib(nibName: "BookedCourseComplexCell", bundle: nil), forCellReuseIdentifier: "bookedcoursecell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 100
        self.tableView.separatorColor = O2Color.BorderGrey
        self.tableView.sectionIndexColor = O2Color.TextGrey
        //self.tableView.backgroundColor = O2Color.BgGreyColor

        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
     
        var t = Local.USER
        self.weekSchedule = WeekBookList(name: Local.USER.name!, date: self.curDate.numDescription)
        
        self.weekSchedule.load({ () -> Void in
            self.days = []
            println("load week done")
            self.daylist = [String:[Book]]()
            for item in self.weekSchedule.datalist {
                let book = item as! Book
                if nil == find(self.daylist.keys.array, book.date) {
                    self.daylist[book.date] = [book]
                    self.days.append(book.date)
                } else {
                    self.daylist![book.date]?.append(book)
                }
                
                
            }
            self.tableView.reloadData()
            }, itemcallback: nil)
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
        let book = self.daylist[self.days[indexPath.section]]![indexPath.row]
        
        cell.setByBook(book)
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
        header.contentView.backgroundColor =  O2Color.BgGreyColor
        header.textLabel.textColor = UIColor.darkGrayColor()
        header.textLabel.font = UIFont(name: "RTWS YueGothic Trial", size: 14)
        //header.textLabel.text = self.daylist.keys.array[section]
        header.alpha = 1 //make the header transparent
        header.contentView.borderColor = O2Color.BorderGrey
        header.contentView.bottomBorderWidth = 0.5
        if section != 0 {
            header.contentView.topBorderWidth = 0.5
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
