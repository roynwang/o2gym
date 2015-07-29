//
//  CircleViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/20/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class CircleViewController: MGSwipeTabBarController , MGSwipeTabBarControllerDelegate{
    
    //var Nav:O2Nav!
    
//    func toggleSegcon(){
//        self.segcon.hidden = !self.segcon.hidden
//        self.navigationItem.setHidesBackButton(false, animated: true)
//        
//    }
    override func viewWillAppear(animated: Bool) {
        O2Nav.sharedInstance()!.showSeg()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        var baritem = self.navigationController?.tabBarItem!
        baritem!.selectedImage = UIImage(named: "circle_active")
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        

        O2Nav(nav:self.navigationController!)
        O2Nav.sharedInstance()!.setSeg(["大气层","热点"], width: 150, indexChangeCallBack: {
            index in
            self.setSelectedIndex(index, animated: true)
            }
        )
        
        
        
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
        O2Nav.sharedInstance()!.swipedSeg(toIndex)
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
