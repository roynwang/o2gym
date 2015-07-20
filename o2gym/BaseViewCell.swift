//
//  BaseViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/20/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class BaseViewCell: UITableViewCell {
    
    func addCorner(cornerType:String?){
        if cornerType == nil {
            return
        }
        let img = UIImage(named: cornerType!)
//        let corner: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        corner.image = img
        let corner: UIImageView = UIImageView(image: img)
        self.contentView.addSubview(corner)
        corner.setTranslatesAutoresizingMaskIntoConstraints(false)
        let views = ["corner" : corner]
        
        var topSpace = NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[corner]",
            options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        var trailSpace = NSLayoutConstraint.constraintsWithVisualFormat("[corner]-8-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        self.contentView.addConstraints(topSpace)
        self.contentView.addConstraints(trailSpace)
    }

}
