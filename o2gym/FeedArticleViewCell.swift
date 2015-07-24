//
//  FeedArticleViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/23/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedArticleViewCell: UITableViewCell {

    @IBOutlet weak var Brief: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Container: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Container.layer.borderWidth = 0.5
        self.Container.layer.borderColor = O2Color.BorderGrey.CGColor
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.Title.textColor = O2Color.TextBlack
        self.Brief.textColor = O2Color.TextGrey
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
