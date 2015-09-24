//
//  OrderedItem.swift
//  o2gym
//
//  Created by xudongbo on 9/3/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class OrderItemCell: UITableViewCell {

    
    var actiontype:String!
    var order:OrderItem!
    
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var ActionBtn: UIButton!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var CreatedTime: UILabel!
    @IBOutlet weak var Customer: UILabel!
    @IBOutlet weak var Coach: UILabel!
    @IBOutlet weak var BillId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadOrder(order:OrderItem){
        self.order = order
        self.Status.text = order.status
        self.CreatedTime.text = order.created
        self.Customer.text = order.customer.displayname
        self.Coach.text = order.coach.displayname
        self.BillId.text = order.billid.toString()
        self.Price.text = "￥" + self.order.amount.toString()
        self.ActionBtn.userInteractionEnabled = true
        self.Status.text = "进行中"
        

        
        if order.status == "unpaid" {
            self.actiontype = "pay"
            self.ActionBtn.setTitle("支付", forState: UIControlState.Normal)
            self.Status.text = "未支付"
            self.ActionBtn.userInteractionEnabled = false
            self.ActionBtn.hidden = false
        }
        if order.status == "paid" {
            self.actiontype = "book"
            //self.ActionBtn.titleLabel!.text = "预约"
            self.ActionBtn.setTitle("预约", forState: UIControlState.Normal)
            self.Status.text = "待预约"
        }
        if order.status == "done" {
            self.Status.text = "已完成"
            
        }
        if order.status == "inprogress" {
            self.Status.text = "已完成"
            self.actiontype = nil
        }
        if self.actiontype == nil || Local.USER.iscoach{
            self.ActionBtn.hidden = true
        }
    
    }
    @IBAction func ActionTapped(sender: AnyObject) {
        if self.actiontype == "pay" {
            //self.pay()
        }
        if self.actiontype == "book" {
            self.book()
        }
    }

    func book(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("book") as! BookViewController
        //cont.coach = self.usr
        //cont.usrname = usrname
        cont.hidesBottomBarWhenPushed = true
        cont.order = self.order
        O2Nav.pushViewController(cont)
    }
}
