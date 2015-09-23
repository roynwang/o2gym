//
//  Helper.swift
//  o2gym
//
//  Created by xudongbo on 7/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit
import Alamofire

public class Helper{
    
    
    
    class func createBarButtonItemFromImg(image:String, selector:Selector, tar:AnyObject?)->UIBarButtonItem{
        let tmpbtn = createButtonFromImg(image, selector: selector, tar: tar)
        return UIBarButtonItem(customView: tmpbtn)
    }
    
    class func createButtonFromImg(image:String, selector:Selector, tar:AnyObject?)->UIButton{
        let img = UIImage(named: image)
        let tmpbtn = UIButton(frame: CGRect(x:0, y:0, width:img!.size.width, height:img!.size.height))
        tmpbtn.setImage(img, forState: UIControlState.Normal)
        tmpbtn.addTarget(tar, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        return tmpbtn
    }
    
    
    class func getExt(url:NSURL)->String{
        let a = url.queryDictionary()
        print(a["ext"])
        return a["ext"]!
        
    }
    class func arrayToJsonString(arr:[String]) -> String{
        let data = try? NSJSONSerialization.dataWithJSONObject(arr, options: [])
        return NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
    }
    class func upload(picdata:NSData, complete: QNUpCompletionHandler!){
        request(Method.GET, Host.UploadTokenGet(), parameters: nil)
            .responseJSON {
                (req, resp, data) -> Void in
//                if error == nil{
                    let dict = JSON(data.value!)
                    let key = dict["key"].stringValue
                    let token = dict["token"].stringValue
                    let mgr:QNUploadManager = QNUploadManager()
                    mgr.putData(picdata, key: key, token: token, complete:complete, option: nil)
//                }
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
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        let posX = (originalWidth  - edge) / 2.0
        let posY = (originalHeight - edge) / 2.0
        
        let cropSquare = CGRectMake(posX, posY, edge, edge)
        
        let imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
        return UIImage(CGImage: imageRef!, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)
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
    
    
    
    class func intToWeekDay(index:Int)->String{
        var ret:String = ""
        switch index {
        case 0:
            ret = "周日"
        case 1:
            ret = "周一"
        case 2:
            ret = "周二"
        case 3:
            ret = "周三"
        case 4:
            ret = "周四"
        case 5:
            ret = "周五"
        case 6:
            ret = "周六"
        default :
            ret =  "error"
        }
        return ret
    }
    
    class func ImageUrlWithSize(url:String, width:CGFloat, height:CGFloat) -> String{
        return ImageUrlWithSize(url, width: Int(width*3), height: Int(height*3))
    }
    class func ImageUrlWithSize(url:String, width:Int, height:Int) -> String{
        return url + "?imageView2/1/w/\(width)/h/\(height)"
    }
}