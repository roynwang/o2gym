//
//  MyGoodCell.swift
//  o2gym
//
//  Created by xudongbo on 9/7/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class MyGoodCell: UITableViewCell {

    @IBOutlet weak var AgendaIcon: UIImageView!
    @IBOutlet weak var Sold: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Amount: UILabel!
    @IBOutlet weak var Introduction: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
        self.AgendaIcon.image = UIImage(named: "agenda")?.add_tintedImageWithColor(O2Color.UpdateToast, style: ADDImageTintStyleKeepingAlpha)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setByProduct(product:Product){
        self.Introduction.text = product.introduction
        self.Price.text = "￥" + product.price.toString()
        self.Amount.text = "课程节数: " + product.amount.toString()
        self.Sold.text = "已售: " + product.soldcount.toString()
    }
}
