//
//  ProfileAvatarCell.swift
//  o2gym
//
//  Created by xudongbo on 8/31/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class ProfileAvatarCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    var tappedAvatar : ((UIView)->Void)!
    @IBAction func showAvatarPicker(sender: UIButton) {
        if self.tappedAvatar != nil{
            self.tappedAvatar!(self.Avatar)
        }
    }
    @IBOutlet weak var Avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


