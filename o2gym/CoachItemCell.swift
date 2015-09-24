//
//  CoachItemCell.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class CoachItemCell: UITableViewCell {

    @IBOutlet weak var RightArrow: UIImageView!
    @IBOutlet weak var Introduction: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.RightArrow.image = UIImage(named: "rightarrow")!.add_tintedImageWithColor(O2Color.BorderGrey, style: ADDImageTintStyleKeepingAlpha)
     
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setByCoach(coach:User){
        self.Avatar.fitLoad(coach.avatar!, placeholder: UIImage(named: "avatar"))
        self.Name.text = coach.displayname
        self.Introduction.text = coach.tags
    }

}
