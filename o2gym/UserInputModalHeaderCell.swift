//
//  UserInputModalHeaderCell.swift
//  o2gym
//
//  Created by xudongbo on 10/13/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class UserInputModalHeaderCell: UITableViewCell {

    var savetapped:(()->Void)?
    var backtapped:(()->Void)?
    
    @IBOutlet weak var Title: UILabel!
    @IBAction func saveTapped(sender: AnyObject) {
        self.savetapped!()
    }
    @IBAction func backTapped(sender: AnyObject) {
        self.backtapped!()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = O2Color.MainColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
