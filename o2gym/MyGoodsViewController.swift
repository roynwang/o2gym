//
//  MyGoodsViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/7/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class MyGoodsViewController: UITableViewController {

    var rydelegate:RYProfileViewDelegate!
    var usrname:String!
    var myGoods:ProductList!
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!, usrname:String) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.usrname = usrname
        self.myGoods = ProductList(name: self.usrname)
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = O2Color.BgGreyColor
        
        self.tableView.registerNib(UINib(nibName: "MyGoodCell", bundle: nil), forCellReuseIdentifier: "mygood")

        self.tableView.bounces = false
        self.myGoods.load({ () -> Void in
            self.tableView.reloadData()
        }, itemcallback: nil)
        
//        let footer  = UIView(frame: CGRectMake(0,0,self.view.frame.width,10))
//        footer.topBorderWidth = 0.5
//        footer.borderColor = O2Color.BorderGrey
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return self.myGoods.count
        }
        return 0
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mygood", forIndexPath: indexPath) as! MyGoodCell
        let product = self.myGoods.datalist[indexPath.row] as! Product

        // Configure the cell...
        cell.setByProduct(product)
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.rydelegate != nil {
            self.rydelegate!.RYscrollViewDidScroll(scrollView)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.borderColor = O2Color.BorderGrey

        if section == 0 {
            header.contentView.bottomBorderWidth = 0.5
        } else {
            header.contentView.topBorderWidth = 0.5
        }
        
        header.contentView.backgroundColor = self.view.backgroundColor
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("book") as! BookViewController
        cont.product = self.myGoods.datalist[indexPath.row] as! Product
        //cont.hidesBottomBarWhenPushed = true
        O2Nav.pushViewController(cont)
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