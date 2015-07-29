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
    var nav:UINavigationBar?
    var circleSeg:HMSegmentedControl!
    var controller:UINavigationController!
    
    init(nav:UINavigationController){
        self.controller = nav
        self.nav = self.controller!.navigationBar
        O2Nav.instance = self
    }

    class func sharedInstance()->O2Nav? {
        return O2Nav.instance
    }
    
    public func setSeg(titles:[String],width:CGFloat,indexChangeCallBack:IndexChangeBlock){
        circleSeg = HMSegmentedControl(sectionTitles: titles)
        
        let startx = self.nav!.frame.width/2 - width/2
        
        
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
//        segcon.indexChangeBlock = {
//            index in
//            self.setSelectedIndex(index, animated: true)
//            
//            
//        }
        circleSeg.indexChangeBlock = indexChangeCallBack
        
        self.nav!.addSubview(self.circleSeg)
    }
    public func setDetail(){
        self.circleSeg.hidden = true
        
    }
    public func swipedSeg(toIndex:Int){
        self.circleSeg.setSelectedSegmentIndex(UInt(toIndex), animated: true)
    }
    
    public func showSeg(){
        
        let animation = CATransaction()
        UIView.transitionWithView(self.circleSeg, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {}, completion: nil)
        

        self.circleSeg.hidden = false
        
    }
    public func showDetail(){
        let animation = CATransaction()
        UIView.transitionWithView(self.circleSeg, duration: 0.4, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {}, completion: nil)
        
        self.circleSeg.hidden = true
        
    }
    public func pushViewController(viewController:UIViewController){
        self.controller.pushViewController(viewController, animated: true)
    }
    
}