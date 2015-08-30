//
//  PicForNYT.swift
//  o2gym
//
//  Created by xudongbo on 8/1/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

class PicForNYT: NSObject, NYTPhoto{
    var image: UIImage?
    var url: NSURL?
    var placeholderImage: UIImage?
    let attributedCaptionTitle: NSAttributedString
    let attributedCaptionSummary = NSAttributedString(string: "summary string", attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let attributedCaptionCredit = NSAttributedString(string: "credit", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
    
    init(image: UIImage?, attributedCaptionTitle: NSAttributedString) {
        self.image = image
        self.attributedCaptionTitle = attributedCaptionTitle
        super.init()
    }

    convenience init(attributedCaptionTitle: NSAttributedString) {
        self.init(image: nil, attributedCaptionTitle: attributedCaptionTitle)
    }
    convenience init(url:NSURL?, attributedCaptionTitle: NSAttributedString){
        self.init(image: nil, attributedCaptionTitle: attributedCaptionTitle)
        self.url = url
    }
}