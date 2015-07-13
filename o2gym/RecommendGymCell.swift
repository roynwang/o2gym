//
//  RecommendGym.swift
//  o2gym
//
//  Created by xudongbo on 7/12/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendGymCell: UITableViewCell {

    @IBOutlet weak var Des: UILabel!
    @IBOutlet weak var BriefImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(item:BaseDataItem){
        let usr:Gym = item as! Gym
        self.BriefImg.load(usr.img_set[0], placeholder: nil, completionHandler:
            { (_, uiimg, _) in
                self.BriefImg.image = Helper.RBResizeImage(uiimg!, targetSize: self.BriefImg.frame.size)
            })
        self.Des.text = usr.name
        
    }
    
    
}
