//
//  PlainTextCell.swift
//  o2gym
//
//  Created by xudongbo on 8/31/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class PlainTextCell: UITableViewCell {

  
    @IBAction func removeTapped(sender: AnyObject) {
        if removeItem != nil {
            self.removeItem!()
        }
    }

    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var PlainText: UILabel!
    
    
    var removeItem:(()->Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
