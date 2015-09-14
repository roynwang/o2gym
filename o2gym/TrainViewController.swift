//
//  CircleViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/20/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class TrainViewController: MGSwipeTabBarController , MGSwipeTabBarControllerDelegate{
    
    
    var book:Book!

    
    var circleSeg:HMSegmentedControl!
    
    //var Nav:O2Nav!
    
    //    func toggleSegcon(){
    //        self.segcon.hidden = !self.segcon.hidden
    //        self.navigationItem.setHidesBackButton(false, animated: true)
    //
    //    }
    override func viewDidAppear(animated: Bool) {
        
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
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        var baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "circle_active")
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
            self.viewControllers[index].viewDidAppear(true)
        }
        self.navigationItem.titleView = circleSeg
        
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let c1 =  sb.instantiateViewControllerWithIdentifier("evalhistory") as! EvalCollectionController

        let c1 = EvalHistoryTableController()
        c1.book = self.book
       
//        let c1 = ProfileViewController()
        
        let c2 = TrainHistoryController()
        c2.book = self.book
       
        self.viewControllers = [c2,c1]
        self.delegate = self
        
        //self.hidesBottomBarWhenPushed = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func swipeTabBarController(swipeTabBarController: MGSwipeTabBarController!, didScrollToIndex toIndex: Int, fromIndex: Int) {
        self.circleSeg.setSelectedSegmentIndex(UInt(toIndex), animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
}
