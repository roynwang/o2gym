//
//  TrainningController.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class TrainningController: UITableViewController, UIAlertViewDelegate {
    
    var name:String!
    var book:Book!
    var date:String!
    var actionSet:[String : WorkoutAction] = [String : WorkoutAction]()
    var curTextField:UITextField!
    
    var groupedTrain:[[Train]]!
    
    var trainList:TrainListByDate!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "EvalHistoryTableCell", bundle: nil), forCellReuseIdentifier: "addnew")
        self.tableView.registerNib(UINib(nibName: "TrainningItemCell", bundle: nil), forCellReuseIdentifier: "traincell")
        self.tableView.registerNib(UINib(nibName: "TrainningHeader", bundle: nil), forCellReuseIdentifier: "trainheader")
        
        self.tableView.separatorStyle = .None
        
        
        
        if self.date == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: "save")
            self.title = "新训练"
        } else {
            self.title = self.date
        }
        
        let gr = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        gr.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(gr)
        
    }
    func dismissKeyboard(gr: UITapGestureRecognizer){
        
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.date != nil {
            self.trainList = TrainListByDate(name: self.name, date: self.date)
            self.trainList.load({ () -> Void in
                //                self.trainListToActions(self.trainList)
                self.groupedTrain = self.groupTrainList(self.trainList)
                self.tableView.reloadData()
                }, itemcallback: nil)
        }
        
        O2Nav.setController(self)
    }
    
    
    
    //    func trainListToActions(tl: TrainListByDate){
    //        for item in tl.datalist {
    //            let train = item as! Train
    //            if nil == self.actions.indexForKey(train.action_name) {
    //                self.actions[train.action_name] = [Train]()
    //                self.actionkey.append(train.action_name)
    //            }
    //            self.actions[train.action_name]?.append(train)
    //        }
    //
    //    }
    func groupTrainList(tl:TrainListByDate)->[[Train]] {
        var dict = [Int:[Train]]()
        var maxGroup = 0
        for item in tl.datalist {
            let train = item as! Train
            if dict.keys.indexOf(train.action_order) == nil {
                dict[train.action_order] = []
            }
            dict[train.action_order]!.append(train)
            maxGroup = maxGroup>train.action_order ? maxGroup : train.action_order
        }
        var ret:[[Train]] = []
        for i in 0...maxGroup {
            ret.append(dict[i]!)
        }
        return ret
    }
    
    func save(){
        self.saveAllTrains()
        let forsave = TrainListByDate(name: self.name, date: NSDate().dateToString())
        if self.book != nil {
            forsave.courseid = self.book.id
        }
        for trains in self.groupedTrain {
            for train in trains {
                forsave.datalist.append(train)
                print(train.repeattimes)
            }
        }
        print(forsave)
        self.view.makeToastActivityWithMessage(message: "正在保存")
        forsave.bulkCreate({ () -> Void in
            self.view.hideToastActivity()
            self.navigationController?.popViewControllerAnimated(true)
            }, error_handler:  {
                (_) in
                self.view.hideToastActivity()
                self.view.makeToast(message: "保存失败")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if self.groupedTrain == nil {return 1}
        return self.groupedTrain.count + 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //        if section >= self.actions.count {
        //            return 1
        //        }
        //        if let arr = self.actions[self.actionkey[section]]{
        //            return arr.count
        //        }
        if self.groupedTrain == nil { return 1 }
        
        if section >= self.groupedTrain.count { return 1}
        
        return self.groupedTrain[section].count
        
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section + 1 == self.numberOfSectionsInTableView(self.tableView){
            return nil
        }
        let cell = TrainningHeader(frame: CGRectMake(0, 0, tableView.frame.width, 40))
        if section != self.numberOfSectionsInTableView(self.tableView) {
            cell.ActionName.text = self.groupedTrain[section][0].action_name
        }
        if self.date != nil {
            cell.AddBtn.hidden = true
            cell.DelBtn.hidden = true
        }
        
        cell.doRemoveSection = {
            self.groupedTrain.removeAtIndex(section)
            self.tableView.deleteSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
        cell.doAddRow = {
            let trainname = self.groupedTrain[section][0].action_name
            let train = Train()
            train.units = self.actionSet[trainname]!.units
            self.self.groupedTrain[section].append(train)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.groupedTrain[section].count-1, inSection: section)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if self.groupedTrain == nil || indexPath.section == self.groupedTrain.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("addnew", forIndexPath: indexPath) as! EvalHistoryTableCell
            cell.DateText.text = " + 添加动作"
            cell.DateText.textAlignment = NSTextAlignment.Center
            cell.DateText.backgroundColor = UIColor.clearColor()
            cell.DateText.textColor = O2Color.MainColor
            
            cell.selectionStyle = .None
            
            if self.date != nil {
                cell.hidden = true
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("traincell", forIndexPath: indexPath) as! TrainningItemCell
        //        let train = self.actions[self.actionkey[indexPath.section]]![indexPath.row]
        let train = self.groupedTrain[indexPath.section][indexPath.row]
        if train.weight != nil {
            cell.Weight.text = train.weight
        }
        if train.repeattimes != nil {
            cell.Repeatttimes.text = train.repeattimes
        }
        cell.Weight.delegate = self
        cell.Repeatttimes.delegate = self
        //        let addedcell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: self.actionkey.count, inSection: indexPath.section)) as! TrainningItemCell
        if train.units != nil {
            cell.Weight.placeholder = train.units.componentsSeparatedByString("|")[0]
            cell.Repeatttimes.placeholder = train.units.componentsSeparatedByString("|")[1]
            
        } else {
            cell.setUnits(self.actionSet[self.groupedTrain[indexPath.section][0].action_name]!)
        }
        cell.userInteractionEnabled = (self.date == nil)
        return cell
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //如果是最后一个 没有header
        if section + 1 == self.numberOfSectionsInTableView(self.tableView){
            return 0
        }
        return 40
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section + 1 == self.numberOfSectionsInTableView(self.tableView){
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let cont =  sb.instantiateViewControllerWithIdentifier("workoutselection") as! TrainCategeoryController
            cont.view.frame = CGRectMake(0, 0, cont.view.frame.width, self.view.frame.height*0.68)
            cont.onActionSelected = {
                (action) in
                // new workout action
                if action.name == nil {
                    self.dismissSemiModalView()
                    let nac = NewActionController()
//                    nac.catesView =  cont.Categeory
                    nac.action = action
                    O2Nav.pushViewController(nac)
                } else {
                    //selected action
                    self.actionSet[action.name] = action
                    let train = Train()
                    train.action_name = action.name
                    let newactionGroup:[Train] = [train]
                    if self.groupedTrain == nil {
                        self.groupedTrain = []
                    }
                    self.groupedTrain.append(newactionGroup)
                    self.tableView.reloadData()
                    self.dismissSemiModalView()
                }
                //self.dismissViewControllerAnimated(true, completion: nil)
            }
            self.presentSemiViewController(cont)
        }
    }
    
    func saveAllTrains(){
        for section in 0..<self.groupedTrain.count {
            let rowcount = self.tableView(self.tableView, numberOfRowsInSection: section)
            
            for row in  0..<rowcount{
                let inputcell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section)) as! TrainningItemCell
                
                let train:Train = self.groupedTrain[section][row]
                train.repeattimes = inputcell.Repeatttimes.text
                train.weight = inputcell.Weight.text
                //                train.action_name = self.actionkey[section]
                train.action_order = section
                train.groupid = row
                train.units = inputcell.Weight.placeholder! + "|" + inputcell.Repeatttimes.placeholder!
                
            }
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // Return NO if you do not want the specified item to be editable.
        return self.date == nil
    }
    
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //
            //            let trainname = self.actionkey[indexPath.section]
            //            self.actions[trainname]?.removeAtIndex(indexPath.row)
            self.groupedTrain[indexPath.section].removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            // Delete the row from the data source
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

extension TrainningController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        self.curTextField = textField
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.curTextField = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if self.curTextField != nil{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if self.curTextField != nil{
            textField.resignFirstResponder()
        }
        return true
    }
}
