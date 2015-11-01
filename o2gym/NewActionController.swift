//
//  NewActionController.swift
//  o2gym
//
//  Created by xudongbo on 10/23/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class NewActionController: UITableViewController {
    
    
    let cateStartId:Int = 1
    var width:CGFloat!
    var action:WorkoutAction!
    var btns:[UIButton]!
    let cateString = ["胸背","腰腹","手臂","臀腿","其他"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新动作"
        
        //self.width = (tableView.frame.width - 100)/5

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerNib(UINib(nibName: "NewActionTextOptionCell", bundle: nil), forCellReuseIdentifier: "option")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cate")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
    }
    func save(){
        
    
        self.view.endEditing(true)
        let cellname = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! NewActionTextOptionCell
        let cellmuscle = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! NewActionTextOptionCell
        let cellunit1 = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! NewActionTextOptionCell
        let cellunit2 = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0)) as! NewActionTextOptionCell
        self.action.name = cellname.getValue()
        self.action.muscle = cellmuscle.getValue()
        self.action.units = cellunit1.getValue()! + "|" + cellunit2.getValue()!
        
       
        if self.action.name == "" || self.action.units.characters.count<=1{
            self.view.makeToast(message: "请填写名称以及至少一个单位")
            return
        }
        
        self.action.save({ (_) -> Void in
            print("save completed")
            self.navigationController?.popViewControllerAnimated(true)
            }) { (msg) -> Void in
                print(msg)
                print("save error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
    
    func cateTapped(btn:UIButton){
        self.action.categeory = btn.tag
        for item in self.btns {
            if item.tag == self.action.categeory {
                item.setBackgroundImage(UIImage(named: "hexagon")?.add_tintedImageWithColor(O2Color.LightMainColor, style: ADDImageTintStyleKeepingAlpha)    , forState: UIControlState.Normal)
            } else {
                item.setBackgroundImage(UIImage(named: "hexagon"), forState: UIControlState.Normal)
            }
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! NewActionTextOptionCell

        // Configure the cell...
        
        switch (indexPath.row) {
        case 0:
            self.btns = []
            let width = (tableView.frame.width - 120)/5
            let cell = tableView.dequeueReusableCellWithIdentifier("cate", forIndexPath: indexPath)
            var startx:CGFloat = 0
            for i in 0...4 {
                startx += 12
                let btn = UIButton(frame: CGRectMake(startx, 10, width, width*1.08))
//                btn.set
                btn.setBackgroundImage(UIImage(named: "hexagon"), forState: UIControlState.Normal)
                btn.addTarget(self, action: "cateTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                btn.tag = i + self.cateStartId
                btn.setTitle(self.cateString[i], forState: UIControlState.Normal)
                btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                cell.addSubview(btn)
                startx += width
                startx += 12
                self.btns.append(btn)
            }
            self.cateTapped(btns[self.action.categeory - self.cateStartId])
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! NewActionTextOptionCell
            cell.TextField.placeholder = "动作名称"
            return cell
        case 2:
               let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! NewActionTextOptionCell
            cell.TextField.placeholder = "具体肌肉"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! NewActionTextOptionCell
            cell.TextField.placeholder = "单位1(Kg/Km/分/秒/Pt/次)"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! NewActionTextOptionCell
            cell.TextField.placeholder = "单位2(Kg/Km/分/秒/Pt/次)"
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("option", forIndexPath: indexPath) as! NewActionTextOptionCell
            cell.TextField.placeholder = "error"
            return cell
        }
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        self.width = (tableView.frame.width - 100)/5
        if indexPath.row == 0 {
            return self.width*1.08 + 20
        }
        return 70
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
