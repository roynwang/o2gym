//
//  MyProductViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class MyProductViewController: UITableViewController {

    var productlist:ProductList!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = O2Color.BgGreyColor
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let b = UIBarButtonItem(title: "添加", style: UIBarButtonItemStyle.Done, target: self, action: "addProduct")
        
        self.navigationItem.rightBarButtonItem = b
        self.tableView.rowHeight = 80

    }
    
    func addProduct(){

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("addproduct") as! AddProductViewController
        //cont.product = self.productlist.datalist[indexPath.section] as! Product
        self.navigationController?.pushViewController(cont, animated: true)

        //let input = MKInputBoxView
//        let input = MKInputBoxView.boxOfType(MKInputBoxType.ThreeTextInput)
//        input.setCancelButtonText("取消")
//        input.setSubmitButtonText("确定")
//        input.setTitle("添加新课程")
//        input.setBlurEffectStyle(UIBlurEffectStyle.Dark)
//        input.show()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.productlist = ProductList(name: Local.USER.name!)
        productlist.load({ () -> Void in
            self.tableView.reloadData()
        }, itemcallback: nil)
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
        
        if self.productlist == nil {
            return 0
        }
        return self.productlist.count

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productoption", forIndexPath: indexPath) as! MyProductCell
        
        
        cell.setByProduct(self.productlist.datalist[indexPath.row] as! Product)
        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    




    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }



    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.tableView.makeToastActivity()
            let prod = self.productlist.datalist[indexPath.row] as! Product
            prod.delete({ (_) -> Void in
                self.tableView.hideToastActivity()
                self.productlist.datalist.removeAtIndex(indexPath.row)
                 tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }, onfail: { (_) -> Void in
                     self.tableView.makeToast(message: "删除失败")
            })
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("addproduct") as! AddProductViewController
        cont.product = self.productlist.datalist[indexPath.section] as! Product
        self.navigationController?.pushViewController(cont, animated: true)
    }

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
        
        let tar = segue.destinationViewController as! AddProductViewController
        tar.
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
