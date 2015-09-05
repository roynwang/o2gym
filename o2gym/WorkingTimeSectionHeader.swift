//
//  WorkingTimeSectionHeader.swift
//  o2gym
//
//  Created by xudongbo on 9/1/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class WorkingTimeSectionHeader: UITableViewCell {
    
    @IBOutlet weak var Title: UILabel!

    @IBAction func addNew(sender: AnyObject) {
        if addTapped != nil {
            self.addTapped!()
        }
    }
    
    var addTapped:(()->Void)!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
