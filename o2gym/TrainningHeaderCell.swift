//
//  TrainningHeaderCell.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class TrainningHeaderCell: UITableViewCell {


    var doAddRow:(()->Void)!
    var doRemoveSection:(()->Void)!
    
    @IBAction func removeRow(sender: AnyObject) {
        if self.doRemoveSection != nil {
            self.doRemoveSection()
        }
    }
    @IBAction func addRow(sender: AnyObject) {
        if self.doAddRow != nil {
            self.doAddRow!()
        }
    }
    @IBOutlet weak var DelBtn: UIButton!
    @IBOutlet weak var ActionName: UILabel!
    @IBOutlet weak var AddBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
