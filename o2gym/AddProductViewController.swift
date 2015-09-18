//
//  AddProductViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class AddProductViewController: UITableViewController {

    var product:Product!
    var create:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = O2Color.BgGreyColor
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let b = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: "save")
        
        self.navigationItem.rightBarButtonItem = b
        
        if product == nil {
            self.create = true
            self.product = Product(coach: Local.USER)
        }
        
        self.hidesBottomBarWhenPushed = true


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func save(){
        if self.create {
            self.product.save({ (_) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }, error_handler: nil)
        } else {
            self.product.update({ (_) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }, onfail: nil)
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
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 4 {
            return 0
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productoption", forIndexPath: indexPath) as! AddProductCell
        
        switch indexPath.section {
        case 0:
            cell.OptionName.text = "课程数量"
            if self.product.amount != nil {
                cell.OptionValue.text = self.product.amount.toString()
            }
            break
        case 1:
            
            cell.OptionName.text = "总价"
            if self.product.price != nil {
                cell.OptionValue.text = self.product.price.toString()
            }
            break
        case 2:
            cell.OptionName.text = "促销"
            if self.product.promotion != nil {
                cell.OptionValue.text = self.product.promotion.toString()
            }
            break
        case 3:
            cell.OptionName.text = "描述"
            if self.product.introduction != nil {
                cell.OptionValue.text = self.product.introduction
            }
            break
        default:
            break
            
        }
        // Configure the cell...
        return cell
    }

    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.borderColor = O2Color.BorderGrey
        
        
        if section != 4 {
            header.contentView.bottomBorderWidth = 0.5
        }
        
        
        header.contentView.topBorderWidth = 0.5
        
        header.contentView.backgroundColor = self.view.backgroundColor
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = MKInputBoxView.boxOfType(MKInputBoxType.NumberInput)
        alert.setSubmitButtonText("好")
        alert.setCancelButtonText("取消")
        alert.borderColor = O2Color.LightMainColor
        
        //alert.setBlurEffectStyle(UIBlurEffectStyle.Dark)
        alert.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.3)
        
        alert.onSubmit = {
            (v1:String!, v2:String!) ->Void in
            print(v1)
            print(v2)
        }
        switch indexPath.section {
        case 0 :
            alert.setTitle("数量")
            alert.onSubmit = {
                (v1:String!, v2:String!) ->Void in
                self.product.amount = Int(v1)
                self.tableView.reloadData()
            }
            break
        case 1 :
            alert.setTitle("价格")
            alert.onSubmit = {
                (v1:String!, v2:String!) ->Void in
                self.product.price = Int(v1)
                self.tableView.reloadData()
            }
            break
        case 2:
            alert.setTitle("促销")
            alert.onSubmit = {
                (v1:String!, v2:String!) ->Void in
                self.product.promotion = Int(v1)
                self.tableView.reloadData()
            }
            break
        case 3:
            alert.setTitle("描述")
            alert.onSubmit = {
                (v1:String!, v2:String!) ->Void in
                self.product.introduction = v1
                self.tableView.reloadData()
            }
            break
        default:
            break
            
            
        }

        alert.show()
        
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
