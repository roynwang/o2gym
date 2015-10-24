//
//  BasicConfigCell.swift
//  o2gym
//
//  Created by xudongbo on 10/13/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class BasicConfigCell: UITableViewCell {

    @IBOutlet weak var RightArrow: UIImageView!
    @IBOutlet weak var OptionKey: UILabel!
    @IBOutlet weak var OptionValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.RightArrow.image = UIImage(named: "rightarrow")!.add_tintedImageWithColor(UIColor.lightGrayColor(), style: ADDImageTintStyleKeepingAlpha)
        
        //self.RightArrow.image = self.RightArrow.
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
