//
//  BookedCourseTitleCell.swift
//  o2gym
//
//  Created by xudongbo on 8/28/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class BookedCourseTitleCell: UITableViewCell {

    @IBOutlet weak var Arrow: UIImageView!

    @IBOutlet weak var SubmitBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.SubmitBtn.backgroundColor = O2Color.LightMainColor
    
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
