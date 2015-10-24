//
//  CoachCell.swift
//  o2gym
//
//  Created by xudongbo on 10/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class CoachCell: UITableViewCell {

    @IBOutlet weak var Sex: UIImageView!
    @IBOutlet weak var Border: UIView!
    @IBOutlet weak var Signature: UILabel!
    @IBOutlet weak var Introduction: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.Border.borderColor = O2Color.BorderGrey
        self.Border.borderWidth = 0.5
        self.backgroundColor = O2Color.BgGreyColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCoach(user:User){
        self.Avatar.fitLoad(user.avatar!)
        self.Name.text = user.displayname
        self.Signature.text = user.signature
        self.Introduction.text = user.introduction
        if user.sex == true {
            self.Sex.image = UIImage(named: "male")
        } else {
            self.Sex.image = UIImage(named: "female")
        }
    }
    
}
