//
//  NewCustomerController.swift
//  o2gym
//
//  Created by xudongbo on 10/26/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class ManualOrderController: UIViewController, UITextFieldDelegate {
    
    var customer:User!
    var coach:User!

    @IBOutlet weak var ProductionIntroduction: UITextField!
    @IBOutlet weak var ProductCourseNumber: UITextField!
    @IBOutlet weak var ProductPrice: UITextField!
    @IBOutlet weak var CustomerPhone: UITextField!
    @IBOutlet weak var CustomerName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新订单"
        self.ProductionIntroduction.delegate = self
        self.ProductCourseNumber.delegate = self
        self.ProductPrice.delegate = self
        self.CustomerPhone.delegate = self
        self.CustomerName.delegate = self
        
        let gr = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(gr)
        
        
        if self.customer != nil {
            self.CustomerPhone.text  = self.customer.name
            self.CustomerName.text = self.customer.displayname
            self.CustomerPhone.userInteractionEnabled = false
            self.CustomerName.userInteractionEnabled = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    


    @IBAction func tapSubmit(sender: AnyObject) {
        self.view.endEditing(true)
        self.view.makeToastActivityWithMessage(message: "创建中")
        let manualorder = ManualOrder()
        manualorder.coach = self.coach
        manualorder.customer_displayname = self.CustomerName.text!
        manualorder.customer_phone = self.CustomerPhone.text!
        manualorder.product_amount = self.ProductCourseNumber.text!
        manualorder.product_price = self.ProductPrice.text!
        manualorder.product_introduction = self.ProductionIntroduction.text
        
        manualorder.save({ (orderitem) -> Void in
            self.view.hideToastActivity()
            self.view.makeToast(message: "订单已创建")
            
            let cont = CustomerDetailController()
            cont.customer =  manualorder.order.customer
            Local.CUSTOMERS?.hasChanged = true
            self.navigationController?.pushViewController(cont, animated: true)
            let vcount = self.navigationController?.viewControllers.count
            self.navigationController?.viewControllers.removeAtIndex(vcount!-2)
            }) { (msg) -> Void in
                self.view.hideToastActivity()
                self.view.makeToast(message: "订单创建失败" + msg)
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
