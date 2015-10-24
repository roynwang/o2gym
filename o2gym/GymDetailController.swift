//
//  GymDetailController.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class GymDetailController: UITableViewController {
    
 
    var headerHeight:CGFloat!
    var gym:Gym!
    //    var headerView : UIView!
    var mask:UIImageView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.whiteColor()
 
    }

    override func viewDidAppear(animated: Bool) {
        print("appeared")
         }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if self.gym == nil {
            return 0
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! SimpleOptionCell
            cell.OptionName.text = "地址"
            cell.OptionValue.text = self.gym.address
            
            return cell
        }
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("text", forIndexPath: indexPath) as! TextOnlyCell

            cell.FullText.text = self.gym.introduction
        
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 2 {
//            O2Nav.showUser(self.gym.coaches[indexPath.row].name!)
//        }
//    }
    
    
}

