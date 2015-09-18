//
//  PicViewer.swift
//  o2gym
//
//  Created by xudongbo on 7/31/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class PicViewer {

    class func showPic(url:String, source:UIView, parent:UIView, controller:UIViewController){
        let imageInfo = JTSImageInfo()
        imageInfo.imageURL = NSURL(string: url)
        imageInfo.referenceRect = source.frame
        imageInfo.referenceView = parent
        
        let imageViewer = JTSImageViewController(
            imageInfo: imageInfo,
            mode: JTSImageViewControllerMode.Image,
            backgroundStyle: JTSImageViewControllerBackgroundOptions.Blurred)
        imageViewer.showFromViewController(controller, transition: JTSImageViewControllerTransition.FromOriginalPosition)
    }
}