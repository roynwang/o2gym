//
//  TrainningPicCell.swift
//  o2gym
//
//  Created by xudongbo on 11/1/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class TrainningPicCell: UITableViewCell {

    @IBOutlet weak var ImgContainer: UIScrollView!
    
    var PicWidth : CGFloat = 0
    var NextX : CGFloat = 0
    var Spacing : CGFloat = 2

    var imgs:[UIImageView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func addPic(img:String){
        let tmp:UIImageView = UIImageView()
        tmp.frame = CGRect(x: self.NextX, y: 0, width: self.PicWidth, height: self.PicWidth)
        self.imgs.append(tmp)
        self.ImgContainer.addSubview(tmp)
        
        let tapped = UITapGestureRecognizer()
        tapped.addTarget(self, action: Selector("showBrowser:"))
        tapped.delegate = self
        tmp.addGestureRecognizer(tapped)
        
        
        tmp.fitLoad(img)
        
        self.NextX += self.PicWidth
        self.NextX += self.Spacing
        self.ImgContainer.contentSize.width = self.NextX
        self.ImgContainer.addGestureRecognizer(tapped)
        
    }
    
}
