//
//  AddProductCell.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class AddProductCell: UITableViewCell {

    @IBOutlet weak var OptionName: UILabel!
    @IBOutlet weak var OptionValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .None

        // Configure the view for the selected state
    }

}
