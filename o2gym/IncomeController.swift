//
//  IncomeController.swift
//  o2gym
//
//  Created by xudongbo on 11/3/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class IncomeController: UIViewController {
    @IBOutlet weak var IncomePrice: MCNumberLabel!
    @IBOutlet weak var CourseIncome: MCNumberLabel!
    @IBOutlet weak var CourseNum: MCNumberLabel!
    
    var income:Income!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.income = Income(name: Local.USER.name!)
        self.title = "收入统计"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        income.loadRemote({ (tar) -> Void in
            print(self.income.sold_price)
            //            let n = NSNumber(integer: NSInteger(self.income.sold_price))
            
//            self.IncomePrice.setValue(NSNumber(integer: self.income.sold_price!), animated: true)
            //            self.IncomePrice.setV
            self.IncomePrice.setValue(NSNumber(integer: self.income.sold_price!), animated: true)
            self.CourseIncome.setValue(NSNumber(integer:self.income.completed_course_price!), animated: true)
            self.CourseNum.setValue(NSNumber(integer:self.income.completed_course!), animated: true)
            }, onfail: { (_) -> Void in
                self.view.makeToast(message: "获取收入失败")
        })
        
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
