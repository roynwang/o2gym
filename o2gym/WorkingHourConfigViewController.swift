//
//  WorkingHourViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/2/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class WorkingHourConfigViewController: UITableViewController {

    var workingHour:RestTime!
    var picker:CZPickerView!
    var curSetting:String = ""
    
    var start:Int! = -1
    var end:Int! = -1
    var noonstart:Int! = -1
    var noonend:Int! = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        
        var b = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: "save")
        
        
        self.navigationItem.rightBarButtonItem = b

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func save(){
        //build noon hour
        //1.empty
        if self.noonstart == -1 {
            self.workingHour.noon_hours = []
        } else {
            //1.not emtpy
            self.workingHour.noon_hours = []
    
                for i in self.noonstart..<self.noonend{
                    self.workingHour.noon_hours.append(i.toString())
                }
        }
        
        //
        self.workingHour.out_hours = []
        if self.start != 0 {
            for i in 0..<self.start {
                self.workingHour.out_hours.append(i.toString())
            }
        }
        
        if self.end != Local.TimeMap.count - 1 {
            for i in self.end..<Local.TimeMap.count-1 {
                self.workingHour.out_hours.append((i + 1).toString())
            }
        }
        self.workingHour.update({ (_) -> Void in
            println(self.workingHour.out_hours)
            println(self.workingHour.noon_hours)
        }, onfail: nil)
        
        
        //self.navigationController?.popViewControllerAnimated(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.workingHour = RestTime(name: Local.USER.name!)
        self.workingHour.loadRemote({ (_) -> Void in
            self.getWorkingStart()
            self.getWorkingEnd()
            self.getNoonStart()
            self.getNoonEnd()
            self.tableView.reloadData()
        }, onfail: nil)
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
        return 4
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row{
        case 0:
            self.curSetting = "start"
            break
        case 1:
            self.curSetting = "end"
            break
        case 2:
            self.curSetting = "noonstart"
            break
        case 3:
            self.curSetting = "noonend"
            break
        default:
            break
        }
        self.picker = CZPickerView(headerTitle: "时间", cancelButtonTitle: "取消", confirmButtonTitle: "确认")
        self.picker.dataSource = self
        self.picker.delegate = self
        //self.picker.needFooterView = true
        self.picker.headerBackgroundColor = O2Color.LightMainColor
        //self.picker.confirmButtonNormalColor = O2Color.LightMainColor
        self.picker.confirmButtonBackgroundColor = O2Color.LightMainColor
        self.picker.show()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("workinghourconfigcell", forIndexPath: indexPath) as! WorkingHourConfigCell
        cell.SettingValue.text = ""
        if indexPath.row == 0 {
            cell.SettingName.text = "上班时间"
            if self.start >= 0  {
                cell.SettingValue.text = Local.TimeMap[self.start]
            }
        }
        if indexPath.row == 1 {
            cell.SettingName.text = "下班时间"
            if self.end >= 0 {
                cell.SettingValue.text = Local.TimeMap[self.end]
            }
        }
        if indexPath.row == 2 {
            cell.SettingName.text = "午休开始"
            if self.noonstart >= 0 {
                cell.SettingValue.text = Local.TimeMap[self.noonstart]
            }
        }
        if indexPath.row == 3 {
            cell.SettingName.text = "午休结束"
            if self.noonend >= 0 {
                cell.SettingValue.text = Local.TimeMap[self.noonend]
            }
        }
        return cell
    }
    //TODO: too complex
    func getWorkingStart(){
        var ret:Int = -1
        if self.workingHour.out_hours.count == 0 || self.workingHour.out_hours[0] != "0"{
            //return Local.TimeMap[0]
            ret = 0
            
        }
        else if self.workingHour.out_hours[0].toInt() == 0 {
            if self.workingHour.out_hours.count == 1 {
                //return Local.TimeMap[1]
                ret = 1
            }
            var i = 0
            while i < self.workingHour.out_hours.count - 1 &&
                self.workingHour.out_hours[i].toInt()! == (self.workingHour.out_hours[i+1].toInt()! - 1) {
                i += 1
            }
            //return Local.TimeMap[self.workingHour.out_hours[i].toInt()! + 1]
            ret = self.workingHour.out_hours[i].toInt()! + 1
        }
        self.start = ret
    }
    //TODO: too complex
    func getWorkingEnd(){
        var ret:Int! = -1
        if self.workingHour.out_hours.count == 0 || self.workingHour.out_hours.last!.toInt() != Local.TimeMap.count-1 {
            //return Local.TimeMap.last!
            ret = Local.TimeMap.count - 1
            self.end = ret
        }
        else if self.workingHour.out_hours.last!.toInt() == Local.TimeMap.count-1 {
            var i = self.workingHour.out_hours.count - 1
            while i > 0 && self.workingHour.out_hours[i].toInt()! == (self.workingHour.out_hours[i-1].toInt()! + 1) {
                i -= 1
            }
            //return Local.TimeMap[self.workingHour.out_hours[i].toInt()!-1]
            ret = self.workingHour.out_hours[i].toInt()! - 1
        }
        self.end = ret
        
    }
    func getNoonStart(){
        if self.workingHour.noon_hours.count == 0 {
            self.noonstart = -1
  
        } else {
            self.noonstart = self.workingHour.noon_hours[0].toInt()!
            
        }
        
    }
    func getNoonEnd(){
        if self.workingHour.noon_hours.count == 0 {
            self.noonend = -1

        } else {
            self.noonend = self.workingHour.noon_hours.last!.toInt()! + 1
           
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

extension WorkingHourConfigViewController:CZPickerViewDataSource,CZPickerViewDelegate{
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        return 7
    }
    func czpickerView(pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        switch self.curSetting {
            case "start":
                return Local.TimeMap[row]
            case "end":
                let delta = Local.TimeMap.count - 7
                return Local.TimeMap[delta + row]
            case "noonstart":
                if row == 0 {
                    return "无午休"
                }
                let delta = Local.TimeMap.count - 24
                return Local.TimeMap[delta + row]
            case "noonend":
                if row == 0 {
                    return "无午休"
                }
                let delta = self.noonstart
                return Local.TimeMap[delta + row]
            default:
                return ""
        }
    }
    
    func czpickerView(pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        switch self.curSetting {
        case "start":
            self.start = row
            break
        case "end":
            self.end = row + 20
            break
        case "noonstart":
            if row == 0 {
                self.noonstart = -1
                self.noonend = -1
            } else {
                self.noonstart = row + 3
            }
            break
        case "noonend":
            if row == 0 {
                self.noonend = -1
                self.noonstart = -1
            } else {
                self.noonend = row + self.noonstart
            }
            break
        default:
            break
        }
        self.tableView.reloadData()
    }
}
