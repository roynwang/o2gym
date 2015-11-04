//
//  NewTrainningController.swift
//  o2gym
//
//  Created by xudongbo on 10/30/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class NewTrainningController: MGSwipeTabBarController , MGSwipeTabBarControllerDelegate {
    
    
    var usrname:String!
    var book:Book!
    var date:String!
    var c1:TrainningController!
    var c2:BodyEvalController!
    
    var isNew:Bool = false
    
    
    var circleSeg:HMSegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let width:CGFloat = 150
        self.circleSeg = HMSegmentedControl(sectionTitles: ["训练","体测"])
        
        let startx:CGFloat = self.navigationController!.navigationBar.frame.width/2 - width/2
        
        
        circleSeg.frame = CGRectMake(startx, 6, width, 30);
        circleSeg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        circleSeg.selectionIndicatorColor = UIColor.whiteColor()
        circleSeg.selectionIndicatorHeight = 1
        if let font = UIFont(name: "RTWS YueGothic Trial", size: 18) {
            circleSeg.titleTextAttributes = [
                NSFontAttributeName: font,
                NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        circleSeg.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        circleSeg.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        circleSeg.indexChangeBlock = {
            index in
            self.setSelectedIndex(index, animated: true)
            
            
        }
        self.navigationItem.titleView = circleSeg
        
        if self.isNew {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
        }
        
        c1 = TrainningController()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        c2 =  sb.instantiateViewControllerWithIdentifier("bodyeval") as! BodyEvalController
        
        c2.isNew = self.isNew
        
        c1.name = self.usrname
        c2.usr = self.usrname
        
        c1.date = self.date
        c2.date = self.date
        
        c1.book = self.book
        c2.book = self.book
        
        self.viewControllers = [c1,c2]
        self.delegate = self

        
    }
    
    func save(){

        self.view.endEditing(true)
        let alert = SIAlertView(title: "训练完成", andMessage: "确定完成吗？完成后数据将不能修改")
        alert.addButtonWithTitle("取消", type: .Cancel) { (_) -> Void in
            alert.dismissAnimated(true)
        }
        
        alert.addButtonWithTitle("确认", type: SIAlertViewButtonType.Default, handler: { (_) -> Void in
            alert.dismissAnimated(true)
            
            self.view.makeToastActivityWithMessage(message: "正在保存")
            self.c1.save({ () -> Void in
                self.c2.save({ () -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                    }, onFail: { (_) -> Void in
                        self.view.hideToastActivity()
                        self.view.makeToast(message: "保存体测数据失败")
                })
                }) { (_) -> Void in
                    self.view.hideToastActivity()
                    self.view.makeToast(message: "保存训练数据失败")
            }
        })
       
        alert.show()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipeTabBarController(swipeTabBarController: MGSwipeTabBarController!, didScrollToIndex toIndex: Int, fromIndex: Int) {
        self.circleSeg.setSelectedSegmentIndex(UInt(toIndex), animated: true)
        (self.viewControllers[toIndex] as! UIViewController).viewWillAppear(true)
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
