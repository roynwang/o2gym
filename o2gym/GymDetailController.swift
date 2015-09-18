//
//  GymDetailController.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class GymDetailController: UITableViewController {
    
    var gymid:Int!
    var gym:Gym!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gym = Gym(id: self.gymid)
        
        gym.loadRemote({ (_) -> Void in
            
            let imageview:UIImageView = UIImageView()
            imageview.load(self.gym.img_set[0], placeholder: nil, completionHandler: { (_, uiimg, err) -> () in
                if uiimg != nil {
                    let header: ParallaxHeaderView = ParallaxHeaderView.parallaxHeaderViewWithImage(uiimg, forSize: CGSizeMake(self.tableView.frame.width, 300)) as! ParallaxHeaderView
                    self.tableView.tableHeaderView = header
                    self.scrollViewDidScroll(self.tableView)
                }
            })
            self.title = self.gym.name!
            O2Nav.setNavigationBarTransformProgress(1)
            O2Nav.setNavTitle(title: self.gym.name!)
            self.tableView.reloadData()
            }, onfail: nil)
        self.navigationController?.navigationBar.translucent = true
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        self.view.backgroundColor = O2Color.BgGreyColor
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
//    override func viewDidAppear(animated: Bool) {
//
//
//    }
    
    override func viewDidAppear(animated: Bool) {
        O2Nav.setController(self)
        //self.scrollViewDidScroll(self.tableView)
        UIView.animateWithDuration(0.5, animations: {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            }, completion: {(_) in
        })
        
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backgroundColor = O2Color.MainColor.colorWithAlphaComponent(0)
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor.colorWithAlphaComponent(0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }
        if section == 2 {
            return self.gym.coaches.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! SimpleOptionCell
            cell.OptionName.text = "地址"
            cell.OptionValue.text = self.gym.address
            return cell
        }
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! SimpleOptionCell
            cell.OptionName.text = "简介"
            cell.OptionValue.text = self.gym.introduction
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("coach", forIndexPath: indexPath) as! CoachItemCell
            let coach = self.gym.coaches[indexPath.row]
            cell.setByCoach(coach)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.borderColor = O2Color.BorderGrey
        
        
        if section != 3 {
            header.contentView.bottomBorderWidth = 0.5
        }
        
        
        header.contentView.topBorderWidth = 0.5
        
        header.contentView.backgroundColor = self.view.backgroundColor
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 60
        }
        return 30
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let header = self.tableView.tableHeaderView
        if header != nil {
            (header as! ParallaxHeaderView).layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            O2Nav.showUser(self.gym.coaches[indexPath.row].name!)
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
