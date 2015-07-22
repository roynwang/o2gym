//
//  CircleViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/20/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class CircleViewController: MGSwipeTabBarController , MGSwipeTabBarControllerDelegate{
    
    var segcon:HMSegmentedControl! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        var baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "circle_active")
        
        segcon = HMSegmentedControl(sectionTitles: ["最热","私教"])
        segcon.tag = 1
        
        let startx = self.navigationController!.navigationBar.frame.width/2 - 60
        
        
        segcon.frame = CGRectMake(startx, 6, 120, 30);
        segcon.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segcon.selectionIndicatorColor = UIColor.whiteColor()
        segcon.selectionIndicatorHeight = 1
        if let font = UIFont(name: "RTWS YueGothic Trial", size: 18) {
            segcon.titleTextAttributes = [
                NSFontAttributeName: font,
                NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        segcon.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        segcon.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        segcon.indexChangeBlock = {
            index in
            self.setSelectedIndex(index, animated: true)

            
        }
        self.navigationController?.navigationBar.addSubview(segcon)
        
        let c1 = FeedStreamViewController()
        c1.view.backgroundColor = UIColor(rgba:"#f6f6f6")
        let c2 = TestViewController()
        c2.view.backgroundColor = UIColor.blueColor()
        self.viewControllers = [c1,c2]
        self.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func swipeTabBarController(swipeTabBarController: MGSwipeTabBarController!, didScrollToIndex toIndex: Int, fromIndex: Int) {
        segcon.setSelectedSegmentIndex(UInt(toIndex), animated: true)
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
