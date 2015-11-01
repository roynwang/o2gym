//
//  GymNowController.swift
//  o2gym
//
//  Created by xudongbo on 9/16/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class GymNowController: MGSwipeTabBarController , MGSwipeTabBarControllerDelegate {
    
    var book:Book!
    
    var circleSeg:HMSegmentedControl!
    
    var addBtn:UIBarButtonItem!
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = O2Color.BgGreyColor

        
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.backgroundColor = O2Color.MainColor
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        
        O2Nav.setController(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let s = ScheduleViewController()
        if  Local.USER.iscoach {
            
            let c = CustomerListController()
            self.circleSeg = HMSegmentedControl(sectionTitles: ["课表","客户"])
            self.viewControllers = [s,c]
            circleSeg.selectionIndicatorHeight = 1
            
                       //        self.navigationItem.rightBarButtonItem = addBtn
            
        } else {
            let c2 = TrainCalendarController()
            self.circleSeg = HMSegmentedControl(sectionTitles: ["训练","课表"])
            self.viewControllers = [c2,s]
            circleSeg.selectionIndicatorHeight = 1
        }
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        let baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "muscle_active")
        
        
        addBtn = UIBarButtonItem(image: UIImage(named: "add_circle"), style: UIBarButtonItemStyle.Done, target: self, action: "newItem")
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = self.addBtn
        
        let width:CGFloat = 150
        
        
        let startx:CGFloat = self.navigationController!.navigationBar.frame.width/2 - width/2
        
        
        circleSeg.frame = CGRectMake(startx, 6, width, 30);
        circleSeg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        circleSeg.selectionIndicatorColor = UIColor.whiteColor()
        
        if let font = UIFont(name: "RTWS YueGothic Trial", size: 18) {
            circleSeg.titleTextAttributes = [
                NSFontAttributeName: font,
                NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        circleSeg.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        circleSeg.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        circleSeg.indexChangeBlock = {
            index in
            //            if index == 1 {
            //                self.navigationItem.rightBarButtonItem = self.addBtn
            //            } else {
            //                self.navigationItem.rightBarButtonItem = nil
            //
            //            }
            self.setSelectedIndex(index, animated: true)
            
            
        }
        self.navigationItem.titleView = circleSeg
        
        
        self.delegate = self
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func swipeTabBarController(swipeTabBarController: MGSwipeTabBarController!, didScrollToIndex toIndex: Int, fromIndex: Int) {
        self.circleSeg.setSelectedSegmentIndex(UInt(toIndex), animated: true)
        
    }
    
    func newItem(){
        if Local.USER.iscoach {
            let cont = ManualOrderController()
            cont.hidesBottomBarWhenPushed = true
            cont.coach = Local.USER
            self.navigationController?.pushViewController(cont, animated: true)
        } else {
            let cont = NewTrainningController()
            cont.hidesBottomBarWhenPushed = true
            cont.usrname = Local.USER.name!
            cont.isNew = true
            self.navigationController?.pushViewController(cont, animated: true)
        }
    }
    
    
}
