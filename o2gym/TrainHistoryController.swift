//
//  TrainHistoryController.swift
//  o2gym
//
//  Created by xudongbo on 9/15/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class TrainHistoryController: UITableViewController, AddableProtocol, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var usrname:String! = Local.USER.name!
    var book:Book!
    var trainHistory:TrainListByDate!
    var isNew:Bool = false
    
    var emptyStr:NSAttributedString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "EvalHistoryTableCell", bundle: nil), forCellReuseIdentifier: "historycell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.rowHeight = 60
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        let attributes = [
            NSFontAttributeName : UIFont(name: "RTWS YueGothic Trial", size: 20)!,
            NSForegroundColorAttributeName : UIColor.lightGrayColor()]
        self.emptyStr = NSAttributedString(string:"...载入中...", attributes:attributes)
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)

    }
    
    
    func refresh(){
       self.viewWillAppear(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        var tmpname = self.usrname
        if self.book != nil {
            tmpname = self.book.customer.name!
        }
        self.trainHistory = TrainListByDate(name: tmpname, date: nil)
        self.trainHistory.load({ () -> Void in
            self.refreshControl?.endRefreshing()
            self.tableView?.reloadData()
            let attributes = [
                NSFontAttributeName : UIFont(name: "RTWS YueGothic Trial", size: 26)!,
                NSForegroundColorAttributeName : UIColor.lightGrayColor()]
            self.emptyStr = NSAttributedString(string:"点击右上角添加训练", attributes:attributes)
            self.tableView.reloadEmptyDataSet()
            }, itemcallback: nil)
    }

    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return self.emptyStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if self.trainHistory == nil {
            return 0
        }
        return self.trainHistory.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historycell", forIndexPath: indexPath) as! EvalHistoryTableCell

        if indexPath.row != self.trainHistory.count {
            let history = self.trainHistory.datalist[indexPath.row] as! Train
            cell.DateText.text = "   " + history.date
            cell.DateText.textColor = O2Color.MainColor
            cell.DateText.textAlignment = NSTextAlignment.Left
            cell.DateText.backgroundColor = UIColor.clearColor()
        }
//        else {
//            cell.DateText.text = " + 开始训练"
//            cell.DateText.textAlignment = NSTextAlignment.Center
//            cell.DateText.backgroundColor = O2Color.MainColor
//            cell.DateText.textColor = UIColor.whiteColor()
//        }
        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let c = TrainningController()
        if indexPath.row == self.trainHistory.count {
            
            c.name = self.book.customer.name
            c.book = self.book
            
        } else {
            if self.book != nil {
                c.name = self.book.customer.name
                c.book = self.book
            } else {
                c.name = self.usrname
            }
            let history = self.trainHistory.datalist[indexPath.row] as! Train
            c.date = history.date.stringByReplacingOccurrencesOfString("-", withString: "") 
            
        }
        c.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(c, animated: true)
    }
    
    
    func addItem() {
        let c = TrainningController()

        c.name = self.usrname
        if self.book != nil  {
            c.name = self.book.customer.name
        }
        c.book = self.book
        c.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(c, animated: true)
        
        

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
