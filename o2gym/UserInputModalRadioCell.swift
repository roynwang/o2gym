//
//  UserInputModalRadioCell.swift
//  o2gym
//
//  Created by xudongbo on 10/13/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class UserInputModalRadioCell: UITableViewCell {

    @IBOutlet weak var OptionValue: UILabel!
    @IBOutlet weak var SelectedImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        self.SelectedImg.image = UIImage(named: "ok")?.add_tintedImageWithColor(O2Color.OkGreen, style: ADDImageTintStyleKeepingAlpha)
        self.SelectedImg.hidden = false
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        if selected {
        // Configure the view for the selected state
            self.SelectedImg.hidden = false
            print("show selected")
        } else {
            self.SelectedImg.hidden = true
        }
    }
    
}
