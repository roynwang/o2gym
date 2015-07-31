//
//  Helper.swift
//  o2gym
//
//  Created by xudongbo on 7/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

public class Helper{
    
    
    
    class func createBarButtonItemFromImg(image:String, selector:Selector, tar:AnyObject?)->UIBarButtonItem{
        let tmpbtn = createButtonFromImg(image, selector: selector, tar: tar)
        return UIBarButtonItem(customView: tmpbtn)
    }

    class func createButtonFromImg(image:String, selector:Selector, tar:AnyObject?)->UIButton{
        var img = UIImage(named: image)
        let tmpbtn = UIButton(frame: CGRect(x:0, y:0, width:img!.size.width, height:img!.size.height))
        tmpbtn.setImage(img, forState: UIControlState.Normal)
        tmpbtn.addTarget(tar, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        return tmpbtn
    }
    
    
    class func getExt(url:NSURL)->String{
        let a = url.queryDictionary()
        println(a["ext"])
        return a["ext"]!
        
    }
    class func arrayToJsonString(arr:[String]) -> String{
        let data = NSJSONSerialization.dataWithJSONObject(arr, options: nil, error: nil)
        return NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
    }
    class func upload(picdata:NSData, complete: QNUpCompletionHandler!){
        request(Method.GET, Host.UploadTokenGet(), parameters: nil)
            .responseJSON(options: nil) {
                (req, resp, data, error) -> Void in
                if error == nil{
                    let dict = JSON(data!)
                    let key = dict["key"].stringValue
                    let token = dict["token"].stringValue
                    let mgr:QNUploadManager = QNUploadManager()
                    mgr.putData(picdata, key: key, token: token, complete:complete, option: nil)
                }
        }
        
    }
    
    class func scaleByWidth(src:UIImage, towidth:CGFloat)->UIImage{
        let oldwidth = src.size.width
        let scaleFactor = towidth / oldwidth
        
        let newHeight = src.size.height * scaleFactor
        let newWidth = src.size.width * scaleFactor
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
        src.drawInRect(CGRectMake(0, 0, newWidth, newHeight));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    class func RBSquareImageTo(image: UIImage, size: CGSize) -> UIImage {
        return RBResizeImage(RBSquareImage(image), targetSize: size)
    }
    
    class func RBSquareImage(image: UIImage) -> UIImage {
        var originalWidth  = image.size.width
        var originalHeight = image.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        var posX = (originalWidth  - edge) / 2.0
        var posY = (originalHeight - edge) / 2.0
        
        var cropSquare = CGRectMake(posX, posY, edge, edge)
        
        var imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
        return UIImage(CGImage: imageRef, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)!
    }
    
    class func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}