//
//  RecommendCourseCell.swift
//  o2gym
//
//  Created by xudongbo on 7/20/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendCourseCell: BaseViewCell {

    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var CourseTitle: UILabel!
    @IBOutlet weak var SubTitle: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SubTitle.layer.cornerRadius = 7
        self.SubTitle.clipsToBounds = true
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(item:BaseDataItem){
        let r = item as! RecommendItem
        self.Img.hnk_setImageFromURL(NSURL(string:r.recommendpic!))
        self.CourseTitle.text = r.recommendtitle
        self.SubTitle.text = "    " + r.recommendsubtitle! + "    "
        self.Location.text = r.recommendloc
        self.Price.text = "￥ " + r.recommendprice!
        self.addCorner(r.corner)
        
    }
    
}
