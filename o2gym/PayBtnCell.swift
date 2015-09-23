//
//  PayBtnCell.swift
//  o2gym
//
//  Created by xudongbo on 9/23/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class PayBtnCell: UITableViewCell {

    @IBOutlet weak var PayBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = O2Color.BgGreyColor
        self.selectionStyle = .None
//        self.selectedBackgroundView = UIView(frame: self.frame)
//        self.selectedBackgroundView?.backgroundColor = O2Color.BgGreyColor

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
