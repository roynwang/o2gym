//
//  TrainActionCell.swift
//  o2gym
//
//  Created by xudongbo on 10/20/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class TrainActionCell: UITableViewCell {

    @IBOutlet weak var SelectedIcon: UIImageView!
    @IBOutlet weak var Muscle: UILabel!
    @IBOutlet weak var Action: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        SelectedIcon.image = UIImage(named: "ok")!.add_tintedImageWithColor(O2Color.OkGreen, style: ADDImageTintStyleKeepingAlpha)
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        self.SelectedIcon.hidden = !selected
        // Configure the view for the selected state
    }
    
}
