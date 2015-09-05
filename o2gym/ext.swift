//
//  ext.swift
//  o2gym
//
//  Created by xudongbo on 7/5/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

//
//  UIColorExtension.swift
//  UIColor-Hex-Swift
//
//  Created by R0CKSTAR on 6/13/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import UIKit



extension String {
    func getCustomLineSpaceString(space:CGFloat) -> NSMutableAttributedString{
        let nstr : NSMutableAttributedString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = space
        nstr.addAttribute(NSKernAttributeName, value: 0.5, range: NSMakeRange(0, nstr.length))
        nstr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, nstr.length))
        return nstr
    }
}

extension UIColor {
    public convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = advance(rgba.startIndex, 1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (count(hex)) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                println("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

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
    func slideInFromTop(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionMoveIn
        slideInFromLeftTransition.subtype = kCATransitionFromBottom
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        // Add the animation to the View's layer
        self.layer.addAnimation(slideInFromLeftTransition, forKey: "slideInFromTopTransition")
    }
    func slideOutToTop(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionFade
        slideInFromLeftTransition.subtype = kCATransitionFromBottom
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        // Add the animation to the View's layer
        self.layer.addAnimation(slideInFromLeftTransition, forKey: "slideOutToTopTransition")
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

extension UIImageView {
    func fitLoad(URL: URLLiteralConvertible, placeholder: UIImage?) {
        self.load(URL, placeholder: placeholder) { (_, uiimg, err) -> () in
            if uiimg != nil {
                self.image = Helper.RBSquareImageTo(uiimg!, size: CGSize(width: self.frame.size.width*2, height: self.frame.size.height*2))
            }
        }
    }
}

extension NSDate {
    class func dateFromString(dateStr:String, formatStr:String="yyyyMMdd")->NSDate {
        let dateFormatter = NSDateFormatter()
        
        //dateFormatter.locale = [NSLocale localeWithIdentifier:@"en_US_POSIX"];
        // see QA1480; NSDateFormatter otherwise reserves the right slightly to
        // modify any date string passed to it, according to user settings, per
        // it's other use, for UI work
        
        dateFormatter.dateFormat = formatStr
        // or whatever you want; per the unicode standards
        
        return dateFormatter.dateFromString(dateStr)!
    }
}

