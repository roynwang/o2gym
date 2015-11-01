//
//  SimpleOptionCell.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class SimpleOptionCell: UITableViewCell {

    @IBOutlet weak var OptionValue: UILabel!
    @IBOutlet weak var OptionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = O2Color.BgGreyColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
