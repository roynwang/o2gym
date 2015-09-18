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
    var actions:[String : [Train]] = [String : [Train]]()
    var actionkey:[String] = [String]()
    
    var trainList:TrainListByDate!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.registerNib(UINib(nibName: "EvalHistoryTableCell", bundle: nil), forCellReuseIdentifier: "addnew")
        self.tableView.registerNib(UINib(nibName: "TrainningItemCell", bundle: nil), forCellReuseIdentifier: "traincell")
        self.tableView.registerNib(UINib(nibName: "TrainningHeaderCell", bundle: nil), forCellReuseIdentifier: "trainheader")
        
        self.tableView.separatorStyle = .None
        
        
        
        if self.date == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: "save")
            self.title = "新训练"
        } else {
            self.title = self.date
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.date != nil {
            self.trainList = TrainListByDate(name: self.name, date: self.date)
            self.trainList.load({ () -> Void in
                self.trainListToActions(self.trainList)
                self.tableView.reloadData()
            }, itemcallback: nil)
        }
    }
    func trainListToActions(tl: TrainListByDate){
        for item in tl.datalist {
            let train = item as! Train
            if nil == self.actions.indexForKey(train.action_name) {
                self.actions[train.action_name] = [Train]()
                self.actionkey.append(train.action_name)
            }
            self.actions[train.action_name]?.append(train)
        }
        
    }
    
    
    func save(){
        self.saveAllTrains()
        let forsave = TrainListByDate(name: self.name, date: NSDate().dateToString())
        if self.book != nil {
            forsave.courseid = self.book.id
        }
        for trains in self.actions.values {
            for train in trains {
                forsave.datalist.append(train)
                print(train.repeattimes)
            }
        }
        print(forsave)
        forsave.bulkCreate({ () -> Void in
            print("save success")
        }, error_handler: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.actions.count + 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section >= self.actions.count {
            return 1
        }
//        if self.actionkey.count == 0 {
//            return 0
//        }
        if let arr = self.actions[self.actionkey[section]]{
            return arr.count
        }
        return 0
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("trainheader") as! TrainningHeaderCell
        if section != self.numberOfSectionsInTableView(self.tableView) {
            cell.ActionName.text = self.actionkey[section]
        }
        if self.date != nil {
            cell.AddBtn.hidden = true
        }
        
        
        cell.doAddRow = {
            //self.saveAllTrains()
            //has filled the last one
            //if self.actions[self.actionkey[section]]!.last?.repeattimes != nil {
                self.actions[self.actionkey[section]]?.append(Train())
            //}
            print(self.actions)
            
            self.tableView.reloadData()
        }
        cell.selectionStyle = .None
        return cell
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        if indexPath.section == self.actions.count {
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
        let train = self.actions[self.actionkey[indexPath.section]]![indexPath.row]
        if train.weight != nil {
            cell.Weight.text = train.weight
        }
        if train.repeattimes != nil {
            cell.Repeatttimes.text = train.repeattimes
        }
   
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
        return 45
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section + 1 == self.numberOfSectionsInTableView(self.tableView){
            let alert = MKInputBoxView.boxOfType(MKInputBoxType.PlainTextInput)
            alert.setTitle("请输入动作名称")
            alert.setSubmitButtonText("好")
            alert.setCancelButtonText("取消")
            alert.borderColor = O2Color.LightMainColor
            //alert.setBlurEffectStyle(UIBlurEffectStyle.Dark)
            alert.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.3)
            alert.onSubmit = {
                (v1:String!, v2:String!) ->Void in
                self.actions[v1] = [Train]()
                self.actions[v1]?.append(Train())
                self.actionkey.append(v1)
                self.tableView.reloadData()
            }
            alert.show()
        }
    }
    
    func saveAllTrains(){
        for section in 0..<self.actionkey.count {
            
            let rowcount = self.tableView(self.tableView, numberOfRowsInSection: section)
            self.actions[self.actionkey[section]] = []
            for row in  0..<rowcount{
                let inputcell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section)) as! TrainningItemCell

                let train = Train()
                train.repeattimes = inputcell.Repeatttimes.text
                train.weight = inputcell.Weight.text
                train.action_name = self.actionkey[section]
                train.action_order = section
                train.groupid = row
                self.actions[self.actionkey[section]]?.append(train)
             
            }
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
