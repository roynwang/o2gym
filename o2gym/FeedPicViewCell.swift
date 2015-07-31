//
//  FeedPicViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/21/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedPicViewCell: UITableViewCell {

    @IBOutlet weak var CellContainer: UIView!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var TextContent: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.CellContainer.layer.borderWidth = 0.5
        self.CellContainer.layer.borderColor = O2Color.BorderGrey.CGColor
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = O2Color.BgGreyColor

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
