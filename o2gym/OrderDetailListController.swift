//
//  OrderDetailListController.swift
//  o2gym
//
//  Created by xudongbo on 9/21/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class OrderDetailListController: UITableViewController {
    var backtwice:Bool = false
    var order:OrderItem!
    
    private var product:Product!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine;
        self.tableView.backgroundColor = O2Color.BgGreyColor
        
        
        self.tableView.registerNib(UINib(nibName: "BookedCourseCell", bundle: nil), forCellReuseIdentifier: "bookedcoursecell")
        
        self.tableView.registerNib(UINib(nibName: "OrderItemCell", bundle: nil), forCellReuseIdentifier: "orderitemcell")
        
        //self.view.makeToastActivity(position: HRToastPositionCenter, message: "载入中")
        self.order.loadRemote({ (_) -> Void in
            self.order.channel = "alipay"
            self.product = Product(productid: self.order.product)
            self.product.loadRemote({ (_) -> Void in
                //self.view.hideToastActivity()
                self.tableView.reloadData()
                }, onfail: nil)
            }, onfail: nil)
       
        self.title = "订单详情"
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        O2Nav.setController(self)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //1 summary
        //2 product detail
        //3 booke info
        //4 pay (0.alipay 1.wx 2.pay
        //5 button
        
        
        if !Local.USER.iscoach && self.order.isLoaded && self.order.status == "unpaid" {
            return 5
        }
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return self.order.booked.count
        case 3:
            return 1
        case 4:
            return 1
            
        default:
            return 0
        }
        
        //return 0
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //1. order summary
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ordersummary", forIndexPath: indexPath) as! OrderSummaryCell
            cell.Date.text = "日期: " + self.order.created
            cell.BillId.text = "单号: " + self.order.billid
            cell.borderColor = O2Color.BorderGrey
            cell.bottomBorderWidth = 0.5
            cell.topBorderWidth = 0.5
            return cell
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("productdescription", forIndexPath: indexPath) as! ProductDescriptionCell
            if self.product != nil && self.product.isLoaded {
                cell.Description.text = self.product.introduction
            }
            cell.borderColor = O2Color.BorderGrey
            cell.bottomBorderWidth = 0.5
            cell.topBorderWidth = 0.5
            return cell
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("productsummary", forIndexPath: indexPath) as! ProductSummaryCell
            if self.product != nil && self.product.isLoaded {
                cell.Amount.text = "课数: " + self.product.amount.toString()
                cell.Price.text = "价格: " + self.order.amount.toString() + "元"
                cell.borderColor = O2Color.BorderGrey
                cell.bottomBorderWidth = 0.5
            }
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("bookedcoursecell", forIndexPath: indexPath) as! BookedCourseCell
            cell.setByBook(self.order.booked[indexPath.row])
            cell.DelBtn.hidden = true
            cell.borderColor = O2Color.BorderGrey
            cell.topBorderWidth = 0.5
            cell.bottomBorderWidth = 0
            if indexPath.row == self.order.booked.count - 1 {
                cell.bottomBorderWidth = 0.5
            }

            return cell
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("payway", forIndexPath: indexPath) as! PayWayCell
            cell.borderColor = O2Color.BorderGrey
            //cell.SelectedIcon.hidden = true
            
            if indexPath.row == 1 {
        
                cell.PayWayIcon.image = UIImage(named: "wechatpay")
                cell.PayWayText.text = "微信支付"
      
                cell.bottomBorderWidth = 0.5
                cell.topBorderWidth = 0.5
                
                if self.order.channel != nil && self.order.channel == "wx" {
                    cell.SelectedIcon.hidden = false
                } else {
                    cell.SelectedIcon.hidden = true
                }

            }
            if indexPath.row == 0 {
                cell.PayWayIcon.image = UIImage(named: "alipay")
                cell.PayWayText.text = "支付宝"
                cell.bottomBorderWidth = 0.5
                cell.topBorderWidth = 0.5
                if self.order.channel != nil && self.order.channel == "alipay" {
                    cell.SelectedIcon.hidden = false
                } else {
                    cell.SelectedIcon.hidden = true
                }
            }
            return cell
        }
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("paybtn", forIndexPath: indexPath) as! PayBtnCell
            
            if self.order.channel != nil && self.order.channel != "" {
                cell.PayBtn.userInteractionEnabled = true
                cell.PayBtn.backgroundColor = O2Color.MainColor
            } else {
                cell.PayBtn.userInteractionEnabled = false
                cell.PayBtn.backgroundColor = O2Color.MainColor.colorWithAlphaComponent(0.5)
            }
            cell.PayBtn.addTarget(self, action: "pay", forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        }

        return UITableViewCell()
        // Configure the cell...
    }
    
    func pay(){
        
        self.view.makeToastActivity(position: HRToastPositionCenter, message: "支付调起中")
       

        self.order.pay ({ () -> Void in
            self.view.hideToastActivity()
            let indicator = 0.5 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(indicator)), dispatch_get_main_queue(), {
                  self.view.makeToastActivity(position: HRToastPositionCenter, message: "查询结果")
            })
          
            let delay = 2.0 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                self.order.loadRemote({ (_) -> Void in
                    self.view.hideToastActivity()
                    if self.order.status == "paid" {
                      
                        if self.backtwice {
                            self.navigationController?.popViewControllerAnimated(false)
                            
                        }
                        self.navigationController?.popViewControllerAnimated(true)
              
                        
                        Local.ORDERLIST?.load({ () -> Void in
                            O2Nav.controller.view.makeToast(message: "支付成功")
                            }, itemcallback: nil)
                        
                        
                    } else {
                        let alert = SIAlertView(title: "查询失败", andMessage: "可能由于网络原因，我们还没有查询到您的支付信息。如果您确认已经完成支付，无需重新付款，稍后您的订单状况会自动更新")
                        alert.addButtonWithTitle("确认", type: SIAlertViewButtonType.Default, handler: { (_) -> Void in
                            alert.dismissAnimated(true)
                            self.navigationController?.popViewControllerAnimated(true)
                            if self.backtwice {
                                self.navigationController?.popViewControllerAnimated(false)
                            }
                        })
                        alert.show()
                    }
                    
                    }, onfail: nil)
            })
            
            }, onFail:{ ()->Void in
                //self.view.makeToast(message: "支付失败")
                self.view.hideToastActivity()
                self.view.makeToast(message: "支付失败", duration: 3, position: HRToastPositionCenter)
        })
    }
    

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 35
        }
        
        if section == 4 {
            return 5
        }
        
        return 25
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor =  O2Color.BgGreyColor
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0:
            return "订单信息"
        case 1:
            return "课程信息"
        case 2:
            return "预定信息"
        case 3:
            return "支付方式"
        default :
            return ""
        }
    }
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//        if indexPath.section == 3 {
//          
//            let wx = tableView.dequeueReusableCellWithIdentifier("payway", forIndexPath: NSIndexPath(forRow: 0, inSection: 3)) as! PayWayCell
//            let ali = tableView.dequeueReusableCellWithIdentifier("payway", forIndexPath: NSIndexPath(forRow: 1, inSection: 3)) as! PayWayCell
//            
//            if indexPath.row == 0 {
//                wx.SelectedIcon.hidden = false
//                ali.SelectedIcon.hidden = true
//                self.order.channel = "wx"
//
//                
//            } else {
//                wx.SelectedIcon.hidden = true
//                ali.SelectedIcon.hidden = false
//                self.order.channel = "alipay"
//            }
//            self.tableView.reloadData()
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
