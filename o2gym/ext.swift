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
            let index   = rgba.startIndex.advancedBy(1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (hex.characters.count) {
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
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
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
                toController.view.slideInFromRight(0.5, completionDelegate: nil)
                }
                else if direction == ">"{
                    self.view.frame.origin.x = self.view.frame.width
                    toController.view.slideInFromLeft(0.5, completionDelegate: nil)
                
                }
                
            },
            completion: { finished in
                self.removeFromParentViewController()
                toController.didMoveToParentViewController(parentController)
                
        })
        
    }

}

extension UIImageView {
    func fitLoad(URL: String, placeholder: UIImage? = nil) {
        var tmp = placeholder
        if tmp == nil {
            tmp = UIImage()
        }
        let imgurl = Helper.ImageUrlWithSize(URL, width:self.frame.width, height: self.frame.height)
        
        var format : HNKCacheFormat? = HNKCache.sharedCache().formats["thumbnail"] as? HNKCacheFormat
        if format == nil {
            format = HNKCacheFormat(name: "thumbnail")
            format!.size = CGSizeMake(self.frame.width*3, self.frame.height*3)
            format!.compressionQuality = 1
            format!.preloadPolicy = HNKPreloadPolicy.LastSession
            format!.scaleMode = HNKScaleMode.AspectFill
            
            //format.size = CGSizeMake(self.frame.width, self.frame.height)
        
        }
        self.hnk_cacheFormat = format
        
//        self.hnk_setImageFromURL(NSURL(string: Helper.ImageUrlWithSize(URL, width:self.frame.width, height: self.frame.height)), placeholder: tmp)
        self.hnk_setImageFromURL(NSURL(string:imgurl), placeholder: tmp)
        
        
//        self.sd_setImageWithURL(NSURL(string: Helper.ImageUrlWithSize(URL, width:self.frame.width, height: self.frame.height)), placeholderImage: tmp)
    }
    
    public typealias CompletionHandler = (UIImage?) -> Void
    
    func loadUrl(URL: String, placeholder:UIImage? = nil, completionHandler: CompletionHandler? = nil){
        var tmp = placeholder
        if tmp == nil {
            tmp = UIImage()
        }
        
        self.hnk_setImageFromURL(NSURL(string: URL)!, placeholder: tmp, success: { (uiimg) -> Void in
            self.image = uiimg
            if completionHandler != nil {
                completionHandler!(uiimg)
            }

            }, failure: nil)
        

    }
    
    //imageview.loadUrl(self.gym.img_set[0], placeholder: nil, completionHandler: { (_,
}

extension NSDate {
    
    func dateToString(formatStr:String="yyyyMMdd") -> String {
        let dateFormatter = NSDateFormatter()
        
        //dateFormatter.locale = [NSLocale localeWithIdentifier:@"en_US_POSIX"];
        // see QA1480; NSDateFormatter otherwise reserves the right slightly to
        // modify any date string passed to it, according to user settings, per
        // it's other use, for UI work
        
        dateFormatter.dateFormat = formatStr
        // or whatever you want; per the unicode standards
        
        return dateFormatter.stringFromDate(self)
    }
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
    
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    
//    func isEqualToDate(dateToCompare : NSDate) -> Bool
//    {
//        //Declare Variables
//        var isEqualTo = false
//        
//        //Compare Values
//        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
//        {
//            isEqualTo = true
//        }
//        
//        //Return Result
//        return isEqualTo
//    }
//    
    
    
    func addDays(daysToAdd : Int) -> NSDate
    {
        let secondsInDays : NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    
    func addHours(hoursToAdd : Int) -> NSDate
    {
        let secondsInHours : NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded : NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}

