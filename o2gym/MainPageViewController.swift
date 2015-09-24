//
//  MainPageViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class MainPageViewController: MGSwipeTabBarController , MGSwipeTabBarControllerDelegate {

    var circleSeg:HMSegmentedControl!
    

    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = false
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
        
        
     
        let c1 = RecommendListViewController()
            //c1.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        c1.view.backgroundColor = O2Color.BgGreyColor
        let c2 = NearByGymController()
        c2.view.backgroundColor = O2Color.BgGreyColor
        self.viewControllers = [c1,c2]
            
        self.circleSeg = HMSegmentedControl(sectionTitles: ["推荐","附近"])
        circleSeg.selectionIndicatorHeight = 1
        
        
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        let baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "o2_active")
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
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
            self.setSelectedIndex(index, animated: true)
        }
        self.navigationItem.titleView = circleSeg
        
        
        
        self.delegate = self
        
        //self.hidesBottomBarWhenPushed = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func swipeTabBarController(swipeTabBarController: MGSwipeTabBarController!, didScrollToIndex toIndex: Int, fromIndex: Int) {
        self.circleSeg.setSelectedSegmentIndex(UInt(toIndex), animated: true)
        (self.viewControllers[toIndex] as! UIViewController).viewWillAppear(true)
    }

}
