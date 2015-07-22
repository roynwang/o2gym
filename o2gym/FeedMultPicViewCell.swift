//
//  FeedMultPicViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/22/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedMultPicViewCell: UITableViewCell {


    @IBOutlet weak var ImgContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var CellContainer: UIView!
    
    @IBOutlet weak var ImgContainer: UIScrollView!
    @IBOutlet weak var Brief: UILabel!
    
    var PicWidth : CGFloat = 0
    var NextX : CGFloat = 0
    var Spacing : CGFloat = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.CellContainer.layer.borderWidth = 0.5
        self.CellContainer.layer.borderColor = O2Color.BorderGrey.CGColor
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        //self.ImgContainerHeight.constant = 150
        
        self.NextX += self.Spacing
        println("!!!!!!!!!!!!!")
        println(self.ImgContainer.frame.width)
        println("!!!!!!!!!!!!!")
        self.PicWidth = (self.ImgContainer.frame.width - 4 * self.Spacing ) / 4.53
        println(self.PicWidth)
        self.ImgContainerHeight.constant = self.PicWidth
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func addPic(img:String){
        let tmp:UIImageView = UIImageView()
        tmp.frame = CGRect(x: self.NextX, y: 0, width: self.PicWidth, height: self.PicWidth)
        self.ImgContainer.addSubview(tmp)
        tmp.load(img)
        self.NextX += self.PicWidth
        self.NextX += self.Spacing
        self.ImgContainer.contentSize = CGSize(width: self.NextX, height: self.ImgContainer.contentSize.height)
    }
    
}
