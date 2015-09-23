//
//  OrderedListViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/3/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class OrderedListViewController: UITableViewController {

    
    
    var orderlist:OrderList!
    
    
    
    var executing:Bool = false

    var nomore:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "OrderItemCell", bundle: nil), forCellReuseIdentifier: "orderitemcell")
        self.orderlist = OrderList(name: Local.USER.name!)

        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.tableView.bounces = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        O2Nav.setController(self)
    }

    override func viewDidAppear(animated: Bool) {
        self.orderlist.load({ () -> Void in
            self.tableView.reloadData()
            }, itemcallback: nil)
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
        return self.orderlist.isLoaded ? self.orderlist.count : 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderitemcell", forIndexPath: indexPath) as! OrderItemCell

        cell.loadOrder(self.orderlist.datalist[indexPath.row] as! OrderItem)
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("orderdetail") as! OrderDetailListController
        cont.order = self.orderlist.datalist[indexPath.row] as! OrderItem
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
        if self.nomore || self.executing {
            return
        }
        self.executing = true
        func addlatest(){
            self.executing = false
            if self.orderlist.delta == 0 {
                self.nomore = true
                return
            }
            self.tableView.reloadData()
            
            //self.showUpdateToast(self.feed.delta)
        }
        self.orderlist.loadHistory(addlatest, itemcallback: nil)
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
