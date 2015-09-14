//
//  BodyEvalController.swift
//  o2gym
//
//  Created by xudongbo on 9/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class BodyEvalController: UITableViewController {
    var usr:String!
    var date:String!
    
    var isNew:Bool = true
    
    var alloptions : BodyEvalList!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isNew {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: "save")
            self.date = NSDate().dateToString()
            self.alloptions = BodyEvalList()
        } else {
            self.alloptions = BodyEvalListByDate(name: usr, date: date)
        }
        
        self.alloptions.load({ () -> Void in
            self.tableView.reloadData()
        }, itemcallback: nil)
        
    }
    
    func save(){
        let forsave = BodyEvalListByDate(name: self.usr, date: self.date)
        for i in 0..<self.tableView(self.tableView, numberOfRowsInSection: 0) {
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! BodyEvalCell
            cell.evalData.value = cell.EvalItem.text
            if cell.evalData.value != nil {
                forsave.datalist.append(cell.evalData)
            }

        }
        if forsave.count != 0 {
            forsave.bulkCreate({ () -> Void in
                println("bulk done")
            }, error_handler: nil)
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
        return self.alloptions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bodyevalitem", forIndexPath: indexPath) as! BodyEvalCell

        cell.setCell(self.alloptions.datalist[indexPath.row] as! BodyEvalItem)
      
        return cell
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
