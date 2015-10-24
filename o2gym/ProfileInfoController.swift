//
//  ProfileInfoController.swift
//  o2gym
//
//  Created by xudongbo on 10/12/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class ProfileInfoController: UITableViewController {

    var gyms:GymList!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "基本资料"
        self.tableView.registerNib(UINib(nibName: "BasicConfigCell", bundle: nil), forCellReuseIdentifier: "basicconfig")
        self.tableView.backgroundColor = O2Color.BgGreyColor
        self.tableView.bounces = false
        //self.tableView.rowHeight = 50
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if Local.USER.iscoach {
            return 5
        }
        return 3
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicconfig", forIndexPath: indexPath) as! BasicConfigCell

        // Configure the cell...
        switch(indexPath.row){
        case 0:
            cell.OptionKey.text = "名字"
            cell.OptionValue.text = Local.USER.displayname
            
        case 1:
            cell.OptionKey.text = "签名"
            cell.OptionValue.text = Local.USER.signature.characters.count == 0 ? "未设置" : Local.USER.signature
        case 2:
            cell.OptionKey.text = "性别"
            cell.OptionValue.text = Local.USER.sex! ? "男":"女"
        case 3:
            cell.OptionKey.text = "简介"
            cell.OptionValue.text = Local.USER.introduction.characters.count == 0 ? "未设置" : Local.USER.introduction
        case 4:
            cell.OptionKey.text = "健身房"
            cell.OptionValue.text = Local.USER.gym
        default:
            cell.OptionKey.text = "错误"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cont = UserInputModalViewController()
 
        cont.headerheight = self.navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height
        
        func updateGym(cont:UIViewController){
            
            cont.view.makeToastActivityWithMessage(message: "正在保存")
            Local.USER.changeGym({ () -> Void in
                cont.view.hideToastActivity()
                cont.view.makeToast(message: "已保存")
                Local.USER.needRefresh = true
                self.tableView.reloadData()
                cont.dismissViewControllerAnimated(true, completion: nil)
                }) { (msg) -> Void in
                    cont.view.hideToastActivity()
                    cont.view.makeToast(message: "保存失败")
            }
        }
        
        func saveUser(cont: UIViewController){
            cont.view.makeToastActivityWithMessage(message: "正在保存")
    
            Local.USER.update({ (_) -> Void in
                cont.view.hideToastActivity()
                cont.view.makeToast(message: "已保存")
                Local.USER.needRefresh = true
                self.tableView.reloadData()
                cont.dismissViewControllerAnimated(true, completion: nil)
                }) { (msg) -> Void in
                    cont.view.hideToastActivity()
                    cont.view.makeToast(message: "保存失败")
            }
        }
        
        switch(indexPath.row){
        case 0:
            cont.fieldName = "名字"
            cont.mode = .Text
            cont.textValue = Local.USER.displayname
            cont.saveCallback = {
                v in
                let newvalue = v as! String
                Local.USER.displayname = newvalue
                saveUser(cont)
            }
            self.presentViewController(cont, animated: true, completion: nil)
            
        case 1:
            cont.fieldName = "签名"
            cont.mode = .Text
            cont.textValue = Local.USER.signature
            cont.saveCallback = {
                v in
                let newvalue = v as! String
                Local.USER.signature = newvalue
                saveUser(cont)
            }
              self.presentViewController(cont, animated: true, completion: nil)
        case 2:
            cont.fieldName = "性别"
            cont.mode = .RadioButton
            cont.radioValueSet = [["男",true],["女",false]]
            cont.radioValue = Local.USER.sex
            cont.saveCallback = {
                v in
                let newvalue = v as! Bool
                Local.USER.sex = newvalue
                saveUser(cont)
            }
            self.presentViewController(cont, animated: true, completion: nil)
            
        case 3:
            cont.fieldName = "简介"
            cont.mode = .Text
            cont.textValue = Local.USER.introduction
            cont.saveCallback = {
                v in
                let newvalue = v as! String
                Local.USER.introduction = newvalue
                saveUser(cont)
            }
            self.presentViewController(cont, animated: true, completion: nil)
        case 4:
            cont.fieldName = "健身房"
            cont.mode = .RadioButton
            self.gyms = GymList()
            self.tableView.makeToastActivity()
            gyms.load({ () -> Void in
                self.tableView.hideToastActivity()
                var valueset:[[AnyObject]] = [[AnyObject]]()
                for item in self.gyms.datalist {
                    let gym = item as! Gym
                    valueset.append([gym.name, gym.id])
                }
                cont.radioValueSet = valueset
                cont.radioValue = Local.USER.gym_id
                cont.radioValueType = "Int"
                self.presentViewController(cont, animated: true, completion: nil)
            }, itemcallback: nil)
            
            cont.saveCallback = {
                v in
                let newvalue = v as! Int
                Local.USER.gym_id = newvalue
                for item in self.gyms.datalist {
                    let gym = item as! Gym
                    if gym.id == newvalue {
                        Local.USER.gym = gym.name
                    }
                }
                updateGym(cont)
              
                self.tableView.reloadData()

            }
            
        default:
            return
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
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
