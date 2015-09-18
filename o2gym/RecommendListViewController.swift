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
        Local.RECOMMEND = RecommendList()
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "RecommendArticleCell", bundle: nil), forCellReuseIdentifier: "recommendarticlecell")
        self.tableView.registerNib(UINib(nibName: "RecommendCoachCell", bundle: nil), forCellReuseIdentifier: "recommendcoachcell")
        self.tableView.registerNib(UINib(nibName: "RecommendGymCell", bundle: nil), forCellReuseIdentifier: "recommendgymcell")
        self.tableView.registerNib(UINib(nibName: "RecommendCourseCell", bundle: nil), forCellReuseIdentifier: "recommendcoursecell")
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // set active image
        let baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "o2_active")
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        Local.RECOMMEND?.load({ () -> Void in
            self.tableView.reloadData()
        }, itemcallback: nil)
        
        Local.login(nil, onfail: nil)
        
        
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
    
    override func viewWillAppear(animated: Bool) {
        O2Nav.setController(self)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        
        
        //UIView.animateWithDuration(0.5, animations: {
        self.navigationController?.navigationBar.backgroundColor = O2Color.MainColor
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
//        O2Nav.resetNav()
        
        if let font = UIFont(name: "RTWS YueGothic Trial", size: 18) {
            O2Nav.nav!.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(1),
                NSFontAttributeName: font
            ]
        }
        
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
        let item = Local.RECOMMEND?.datalist[i] as! RecommendItem
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
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 4
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let i = indexPath.row
        let item = Local.RECOMMEND?.datalist[i] as! RecommendItem
        print(item.recommendcontent!.type)
        
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
        let item = Local.RECOMMEND?.datalist[indexPath.row] as! RecommendItem
  
        switch(item.recommendcontent!.type){
        case "weibo":
            let wb = item.recommendcontent as! Weibo
            O2Nav.showArticle(wb.id!)
            break
        case "user":
            O2Nav.showUser((item.recommendcontent as! User).name!)
            break
        case "gym":
            O2Nav.showGym((item.recommendcontent as! Gym).id!)
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
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
