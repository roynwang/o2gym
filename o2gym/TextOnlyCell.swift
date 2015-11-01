//
//  TextOnlyCell.swift
//  o2gym
//
//  Created by xudongbo on 10/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class TextOnlyCell: UITableViewCell {

    @IBOutlet weak var FullText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = O2Color.BgGreyColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
