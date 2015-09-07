//
//  RecommendTableViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/7/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: Selector("loadmore"), forControlEvents: UIControlEvents.ValueChanged)
//        self.refreshControl = refreshControl


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadmore(){
        func addlatest(){
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        Local.FEED?.loadLatest(addlatest, onfail: nil)
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
        return Local.FEED!.count + 1
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == Local.FEED!.count {
            Local.FEED?.loadHistory(self.tableView.reloadData, itemcallback: nil)
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let i = indexPath.row
        if i < Local.FEED!.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("basiccell", forIndexPath: indexPath) as! UITableViewCell
            let wb = Local.FEED!.datalist[i] as! Weibo
            cell.textLabel?.text = wb.title
            cell.detailTextLabel?.text = wb.brief
            return cell
        }
        else{
             let cell = tableView.dequeueReusableCellWithIdentifier("loadhistory", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "加载更多..."
            if Local.FEED?.nexturl == nil {
                cell.textLabel?.text = "没有更多了"
            }
            return cell
            
        }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let index:Int? = self.tableView.indexPathForSelectedRow()?.row
        let tarnav:UINavigationController = segue.destinationViewController as! UINavigationController
//        let tarview = tarnav.childViewControllers[0] as! WeiboViewController
//        tarview.weibo = Local.FEED?.datalist[index!] as! Weibo?
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}
