//
//  RecommendGym.swift
//  o2gym
//
//  Created by xudongbo on 7/12/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendGymCell: BaseViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Price: UILabel!

    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Tags: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.Tags.layer.cornerRadius = 7
        self.Tags.clipsToBounds = true
       
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(item:BaseDataItem){
        let usr:RecommendItem = item as! RecommendItem
//        self.Img.loadUrl(usr.recommendpic!, placeholder: nil) { (_) -> () in
//            UIImageView.addShadowWithColor(UIColor.blackColor(), inImageView: self.Img)
//        }
        self.Img.loadUrl(usr.recommendpic!, placeholder: nil)
        self.Title.text = usr.recommendtitle
        self.Tags.text = "   " + usr.recommendsubtitle! + "    "
        self.Location.text = usr.recommendloc
        self.Price.text = usr.recommendprice
        self.addCorner(usr.corner)
    }
    
    
}
