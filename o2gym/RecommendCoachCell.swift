//
//  RecommendCoach.swift
//  o2gym
//
//  Created by xudongbo on 7/12/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendCoachCell: BaseViewCell {

 
    @IBOutlet weak var Img: UIImageView!

    @IBOutlet weak var Tags: UILabel!

    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var Loc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Tags.layer.cornerRadius = 7
        self.Tags.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setContent(item:BaseDataItem){
        let r = item as! RecommendItem
        self.Name.text = r.recommendtitle
        self.Tags.text = "   " + r.recommendsubtitle! + "    "
        self.Img.load(r.recommendpic!)
        self.Loc.text = r.recommendloc
        self.addCorner(r.corner)
    }
    
}
