//
//  FeedArticleViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/21/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedArticleViewCell: UITableViewCell {

    @IBOutlet weak var HrHeight: NSLayoutConstraint!

    
    @IBOutlet weak var Brief: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Container: UIView!
//    @IBOutlet weak var ArticleBrief: UILabel!
//    @IBOutlet weak var Img: UIImageView!
//    @IBOutlet weak var ArticleTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.HrHeight.constant = 0.5
        self.Container.layer.borderWidth = 0.5
        self.Container.layer.borderColor = O2Color.BorderGrey.CGColor
        //self.Container.layer.borderColor = UIColor.blackColor().CGColor
        self.selectionStyle =
            UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
