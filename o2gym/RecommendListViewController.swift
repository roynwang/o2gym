//
//  RecommendListViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/12/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "RecommendArticleCell", bundle: nil), forCellReuseIdentifier: "recommendarticlecell")
        self.tableView.registerNib(UINib(nibName: "RecommendCoachCell", bundle: nil), forCellReuseIdentifier: "recommendcoachcell")
        self.tableView.registerNib(UINib(nibName: "RecommendGymCell", bundle: nil), forCellReuseIdentifier: "recommendgymcell")
        self.tableView.registerNib(UINib(nibName: "RecommendCourseCell", bundle: nil), forCellReuseIdentifier: "recommendcoursecell")
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        
        
        // set active image
        var baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "o2active")
        
    
        
        
        //        var bounds = self.navigationController?.navigationBar.bounds as CGRect!
        //        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        //        visualEffectView.frame = bounds
        //        visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        //        self.navigationController?.navigationBar.addSubview(visualEffectView)
        
        
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
        //println(Local.RECOMMEND!.count)
        return Local.RECOMMEND!.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let i = indexPath.row
        var item = Local.RECOMMEND?.datalist[i] as! RecommendItem
        switch(item.recommendcontent!.type){
        case "weibo":
            return 130
        case "user":
            return 167
        case "course":
            return 167
        default:
            return 130
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let i = indexPath.row
        var item = Local.RECOMMEND?.datalist[i] as! RecommendItem
        println(item.recommendcontent!.type)
        
        switch(item.recommendcontent!.type){
        case "weibo":
            let cell = tableView.dequeueReusableCellWithIdentifier("recommendarticlecell", forIndexPath: indexPath) as! RecommendArticleCell
            cell.setContent(item)
            return  cell
        case "user":
            let cell = tableView.dequeueReusableCellWithIdentifier("recommendcoachcell", forIndexPath: indexPath) as! RecommendCoachCell
            cell.setContent(item)
            return  cell
        case "gym":
            let cell = tableView.dequeueReusableCellWithIdentifier("recommendgymcell", forIndexPath: indexPath) as! RecommendGymCell
            cell.setContent(item)
            return  cell
        case "course":
            let cell = tableView.dequeueReusableCellWithIdentifier("recommendcoursecell", forIndexPath: indexPath) as! RecommendCourseCell
            cell.setContent(item)
            return  cell
        default:
            return UITableViewCell()
        }
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var item = Local.RECOMMEND?.datalist[indexPath.row]
        switch(item!.type){
        case "user":
            self.performSegueWithIdentifier("coachdetail", sender: nil)
            break
        default:
            self.performSegueWithIdentifier("testsegue", sender: nil)
        }
    }
    
    
    //    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        let i = indexPath.row
    //        var item = Local.RECOMMEND?.datalist[i]
    //        switch(item!.type){
    //        case"weibo":
    //            return 173
    //        case "user":
    //            return 105
    //        case "gym":
    //            return 100
    //        default:
    //            return 88
    //        }
    //
    //    }
    
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
        // Get the new view controller using [segue destinationViewController].
        switch segue.identifier! {
        case "coachdetail":
            let coachvc = segue.destinationViewController.childViewControllers[0] as! CoachDetailViewController
            coachvc.coach = Local.RECOMMEND?.datalist[self.tableView.indexPathForSelectedRow()!.row] as! User?
            break
        default:
            break
        }
        // Pass the selected object to the new view controller.
    }
    
    
}
