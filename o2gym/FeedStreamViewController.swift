//
//  FeedStreamViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/21/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedStreamViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "FeedPicViewCell", bundle: nil), forCellReuseIdentifier: "feedpicviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedArticleViewCell", bundle: nil), forCellReuseIdentifier: "feedarticleviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedMultPicViewCell", bundle: nil), forCellReuseIdentifier: "feedmultpicviewcell")
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("feedpicviewcell", forIndexPath: indexPath) as! FeedPicViewCell
            
            let nstr = "房地产税立法初稿基本成形 税率或由地方决定沪指涨0.64%收复4000点 两市超300个股涨停"
        
            cell.TextContent.attributedText = nstr.getCustomLineSpaceString(CGFloat(4))
            cell.Img.load("http://i.imgur.com/oI1bF48.jpg")
            // Configure the cell...
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("feedarticleviewcell", forIndexPath: indexPath) as! FeedArticleViewCell
            cell.Img.load("http://i.imgur.com/oI1bF48.jpg")
            cell.Title.text = "越吃越瘦"
            cell.Brief.attributedText = "历史搜索记录显示以往搜索内容、搜索日期以及曾经访问的站点。此外，它还会根据以往单击的结果，帮助改进搜索结果。".getCustomLineSpaceString(4)
            // Configure the cell...
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("feedmultpicviewcell", forIndexPath: indexPath) as! FeedMultPicViewCell
            cell.addPic("http://i.imgur.com/oI1bF48.jpg")
            cell.addPic("http://i.imgur.com/oI1bF48.jpg")
            cell.addPic("http://i.imgur.com/oI1bF48.jpg")
            cell.addPic("http://i.imgur.com/oI1bF48.jpg")
            cell.Brief.attributedText = "历史搜索记录显示以往搜索内容、搜索日期以及曾经访问的站点。此外，它还会根据以往单击的结果，帮助改进搜索结果。".getCustomLineSpaceString(2)
//            cell.Title.text = "越吃越瘦"
//            cell.Brief.attributedText = "历史搜索记录显示以往搜索内容、搜索日期以及曾经访问的站点。此外，它还会根据以往单击的结果，帮助改进搜索结果。".getCustomLineSpaceString(4)
            // Configure the cell...
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
