//
//  O2Nav.swift
//  o2gym
//
//  Created by xudongbo on 7/29/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class O2Nav{
    
    static var instance:O2Nav? = nil
    static var nav:UINavigationBar?
    var circleSeg:HMSegmentedControl!
    static var controller:UIViewController!
    
    class func sharedInstance()->O2Nav? {
        O2Nav.instance = O2Nav.instance ?? O2Nav()
        return O2Nav.instance
    }
    class func setController(nav:UIViewController){
        O2Nav.controller = nav
        O2Nav.nav = nav.navigationController?.navigationBar
    }
    

    
    class func pushViewController(viewController:UIViewController){
        O2Nav.controller.navigationController!.pushViewController(viewController, animated: true)
    }
    
    class func setNavigationBarTransformProgress(progress:CGFloat){
        if progress >= 0 {
            O2Nav.nav!.lt_setBackgroundColor(O2Color.MainColor.colorWithAlphaComponent(1-progress))
            O2Nav.nav!.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(1-progress)
            ]

        }
    }
    
}