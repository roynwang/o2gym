//
//  OrderSummaryCell.swift
//  o2gym
//
//  Created by xudongbo on 9/23/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class OrderSummaryCell: UITableViewCell {

    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var BillId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
