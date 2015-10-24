//
//  UserInputModelViewController.swift
//  o2gym
//
//  Created by xudongbo on 10/13/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit


enum UserInputModalMode{
    case Text
    case RadioButton
}

class UserInputModalViewController: UITableViewController {
    
    
    var fieldName:String!
    var mode:UserInputModalMode = .Text
    
    var saveCallback:((AnyObject)->Void)!
    
    
    var radioValueSet:[[AnyObject]]!
    var radioValue:AnyObject!
    var radioValueType:String = "Bool"
    
    var textValue:String = ""
    
    var headerheight:CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
    
    //    required init?(coder aDecoder: NSCoder) {
    //           super.init(coder: aDecoder)!
    //    }
    convenience init(){
        self.init(style: UITableViewStyle.Grouped)
    }
    
    //    override init(style: UITableViewStyle) {
    //        super.init(style: style)
    //    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerNib(UINib(nibName: "UserInputModalTextViewCell", bundle: nil), forCellReuseIdentifier: "text")
        self.tableView.registerNib(UINib(nibName: "UserInputModalRadioCell", bundle: nil), forCellReuseIdentifier: "radio")
        self.tableView.registerNib(UINib(nibName: "UserInputModalHeaderCell", bundle: nil), forCellReuseIdentifier: "header")
        //self.tableView.rowHeight = self.height
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        let header = tableView.dequeueReusableCellWithIdentifier("header") as! UserInputModalHeaderCell
        header.backtapped = {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        header.savetapped = {
            self.saveCallback(self.getNewValue())
        }
        
        header.Title.text = self.fieldName
        header.frame = CGRectMake(0, 0, self.tableView.frame.width, self.headerheight)
        
        self.tableView.tableHeaderView = header
        
        //        self.tableView.bounces = false
        //        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = O2Color.BgGreyColor
        self.tableView.rowHeight = 50
        
        
    }
    
    func getNewValue()->AnyObject{
        switch self.mode {
        case .Text:
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! UserInputModalTextViewCell
            return cell.InputText.text!
        case .RadioButton:
            for i in 0 ..< self.radioValueSet.count {
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! UserInputModalRadioCell
                if cell.selected {
                    return self.radioValueSet[i][1]
                }
            }
            return true
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
        if self.mode == .Text{
            return 1
        }
        if self.mode == .RadioButton {
            return self.radioValueSet.count
        }
        return 0
    }
    
    override func viewWillAppear(animated: Bool) {
        var selected:Int = -1
        if self.mode == .RadioButton{
            
            for i in 0 ..< self.radioValueSet.count {
                if self.radioValueType == "Bool"{
                    if self.radioValueSet[i][1] as! Bool == self.radioValue as! Bool {
                        selected = i
                        break
                    }
                    
                }
                if self.radioValueType == "Int" {
                    if self.radioValueSet[i][1] as! Int == self.radioValue as! Int {
                        selected = i
                        break
                    }
                    
                }
                if self.radioValueType == "String" {
                    if self.radioValueSet[i][1] as! String == self.radioValue as! String {
                        selected = i
                        break
                    }
                    
                }
            }
            if selected != -1 {
                self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: selected, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch self.mode {
        case .Text:
            let cell = tableView.dequeueReusableCellWithIdentifier("text", forIndexPath: indexPath) as! UserInputModalTextViewCell
            cell.InputText.text = self.textValue
            let gr = UITapGestureRecognizer(target: cell, action: "touchOutside:")
            self.tableView.addGestureRecognizer(gr)
            return cell
        case .RadioButton:
            let cell = tableView.dequeueReusableCellWithIdentifier("radio", forIndexPath: indexPath) as! UserInputModalRadioCell
            
            cell.OptionValue.text = self.radioValueSet[indexPath.row][0] as? String
            
            
            
            
            
            return cell
            
        }
        
        // Configure the cell...
        
        //        return cell
    }
    
    //    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        if self.mode == .RadioButton {
    //            let cell = tableView.cellForRowAtIndexPath(indexPath) as! UserInputModalRadioCell
    //            print("xxxxxx")
    //        }
    //    }
    
    
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
