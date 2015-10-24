//
//  PayWayCell.swift
//  o2gym
//
//  Created by xudongbo on 9/23/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class PayWayCell: UITableViewCell {

    @IBOutlet weak var SelectedIcon: UIImageView!
    @IBOutlet weak var PayWayText: UILabel!
    @IBOutlet weak var PayWayIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        self.SelectedIcon.image = UIImage(named: "ok")?.add_tintedImageWithColor(O2Color.OkGreen, style: ADDImageTintStyleKeepingAlpha)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        //self.SelectedIcon.hidden = false
    }

}
