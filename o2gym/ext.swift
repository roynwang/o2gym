//
//  ext.swift
//  o2gym
//
//  Created by xudongbo on 7/5/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

extension NSURL {
    func queryDictionary() -> [String:String] {
        let components = self.query?.componentsSeparatedByString("&")
        var dictionary = [String:String]()
        
        for pairs in components ?? [] {
            let pair = pairs.componentsSeparatedByString("=")
            if pair.count == 2 {
                dictionary[pair[0]] = pair[1]
            }
        }
        
        return dictionary
    }
}

extension Bool {
    func toString()->String{
        if self{
            return "true"
        }
        return "false"
    }
}

extension Int {
    func toString() ->String {
        return String(self)
    }
}

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        // Add the animation to the View's layer
        self.layer.addAnimation(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    func slideInFromRight(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromRight
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        // Add the animation to the View's layer
        self.layer.addAnimation(slideInFromLeftTransition, forKey: "slideInFromRightTransition")
    }
}

extension UIViewController {
    func switchTo(toController: UIViewController, parentController: UIViewController, direction: String) {
 
        self.willMoveToParentViewController(parentController)
        parentController.addChildViewController(toController)
        
        toController.view.frame = self.view.bounds
        
        parentController.transitionFromViewController(self,
            toViewController: toController, duration: 0.5,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                if direction == "<" {
                self.view.frame.origin.x = 0 - self.view.frame.width
                toController.view.slideInFromRight(duration: 0.5, completionDelegate: nil)
                }
                else if direction == ">"{
                    self.view.frame.origin.x = self.view.frame.width
                    toController.view.slideInFromLeft(duration: 0.5, completionDelegate: nil)
                
                }
                
            },
            completion: { finished in
                self.removeFromParentViewController()
                toController.didMoveToParentViewController(parentController)
                
        })
        
    }

}
