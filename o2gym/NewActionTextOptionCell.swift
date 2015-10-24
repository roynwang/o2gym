//
//  NewActionTextOptionCell.swift
//  o2gym
//
//  Created by xudongbo on 10/23/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class NewActionTextOptionCell: UITableViewCell {

    @IBOutlet weak var TextField: HoshiTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getValue()->String?{
        return self.TextField.text
    }
    
}
