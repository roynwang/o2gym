//
//  CustomerListController.swift
//  o2gym
//
//  Created by xudongbo on 10/12/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class CustomerListController: UITableViewController {
    
    
    var coachname:String!
    
    var customerlist:CustomerList!
    
    var dataSource:NSMutableArray!
    var rowDataSource:NSMutableArray!
    var titleDataSource:NSMutableArray!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        self.coachname = Local.USER.name!
        self.customerlist = CustomerList(name: self.coachname)
        
        
        self.dataSource = NSMutableArray()
        self.rowDataSource = NSMutableArray()
        self.titleDataSource = NSMutableArray()
        
        
        
        self.customerlist.load({ () -> Void in
            //order it
            
            self.dataSource.addObjectsFromArray(self.customerlist.datalist as! [User])
           // self.dataSource.sort
            self.dataSource.sortContactTOTitleAndSectionRowWithKey_A_CE("name", callBack: { (result, titleArr, rowArr) -> Void in
                self.rowDataSource.addObjectsFromArray(rowArr)
                self.titleDataSource.addObjectsFromArray(titleArr)
            })
            
            self.tableView.reloadData()
            }, itemcallback: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerNib(UINib(nibName: "CustomerItemCell", bundle: nil), forCellReuseIdentifier: "customer")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.customerlist == nil {
            return 0
        }
         return self.rowDataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.customerlist == nil {
            return 0
        }
        return self.rowDataSource[section].count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customer", forIndexPath: indexPath) as! CustomerItemCell
        
        cell.setContent(self.rowDataSource[indexPath.section][indexPath.row] as! User)
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.titleDataSource as AnyObject as? [String]
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleDataSource[section] as? String
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let usr = self.rowDataSource[indexPath.section][indexPath.row] as! User
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("train") as! TrainViewController
        cont.usrname = usr.name
        cont.addable = false
        cont.hidesBottomBarWhenPushed = true
        O2Nav.pushViewController(cont)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
