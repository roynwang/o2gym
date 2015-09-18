//
//  CircleViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/20/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class CircleViewController: MGSwipeTabBarController , MGSwipeTabBarControllerDelegate{
    
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
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)


        //UIView.animateWithDuration(0.5, animations: {
        self.navigationController?.navigationBar.backgroundColor = O2Color.MainColor
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        //})
//        UIView.transitionWithView( self.navigationController!.navigationBar,duration: 0.5, options: UIViewAnimationOptions.ShowHideTransitionViews, animations: {},completion: nil)
       
        //self.tabBarController?.tabBar.hidden = false
        //self.tabBarController.set
        O2Nav.setController(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        let baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "circle_active")
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        let width:CGFloat = 150
        self.circleSeg = HMSegmentedControl(sectionTitles: ["大气层","热点"])
        
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
        
        
        let c1 = FeedStreamViewController()
        c1.view.backgroundColor = UIColor(rgba:"#f6f6f6")
        let c2 = TestViewController()
        c2.view.backgroundColor = UIColor.blueColor()
        self.viewControllers = [c1,c2]
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
