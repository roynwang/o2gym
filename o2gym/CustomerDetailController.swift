//
//  CustomerDetailController.swift
//  o2gym
//
//  Created by xudongbo on 10/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class CustomerDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var Orders: UITableView!


    var customer:User!
    var coach:User = Local.USER
    var orderList:OrderList!
    var header:CustomerHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.Orders.registerNib(UINib(nibName: "OrderItemCell", bundle: nil), forCellReuseIdentifier: "order")
        self.Orders.delegate = self
        self.Orders.dataSource = self
        
        self.Orders.rowHeight = 80
        self.Orders.tableFooterView = UIView(frame: CGRect.zero)
        self.title = "客户详情"
        
        self.header =  CustomerHeader(frame: CGRectMake(0,0, self.Orders.frame.width, 100))
        self.Orders.tableHeaderView = self.header
        self.header.setUser(self.customer)
        
        self.header.PhoneCall.addTarget(self, action: "makeCall", forControlEvents: UIControlEvents.TouchUpInside)
        self.header.Note.addTarget(self, action: "showNotes", forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.orderList = OrderList(name: customer.name!, coach: coach.name!)
        self.orderList.load({ () -> Void in
            self.Orders.reloadData()
            }, itemcallback: nil)
    }
    override func viewDidAppear(animated: Bool) {
        O2Nav.setController(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.orderList == nil {
            return 0
        }
        return self.orderList.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "订单列表"
    }
    
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let btn = UIButton(frame: CGRectMake(view.frame.width-50, 0, 50, 50))
        btn.setImage(UIImage(named: "add_circle")?.add_tintedImageWithColor(UIColor.darkGrayColor(), style: ADDImageTintStyleKeepingAlpha), forState: UIControlState.Normal)
        btn.addTarget(self, action: "addOrder", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn)
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.textLabel!.font = UIFont(name: "Avenir", size: 16)
        
    }
    func addOrder(){
        let neworder = ManualOrderController()
        neworder.customer = self.customer
        self.navigationController?.pushViewController(neworder, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("order", forIndexPath: indexPath) as! OrderItemCell
        let order = self.orderList.datalist[indexPath.row] as! OrderItem
        if order.status  == "paid" {
            cell.loadOrder(order, showaction:true)
        } else {
            cell.loadOrder(order, showaction:false)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let order = self.orderList.datalist[indexPath.row] as! OrderItem
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("orderdetail") as! OrderDetailListController
        cont.order = order
        self.navigationController?.pushViewController(cont, animated: true)
        
    }
    
    func showNotes(){
        let cont = TrainCalendarController()
        cont.usrname = self.customer.name!
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
    func makeCall(){
        print(self.customer.name!)
        if let url = NSURL(string: "tel://\(self.customer.name!)") {
            UIApplication.sharedApplication().openURL(url)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
