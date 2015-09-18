//
//  MyProductCell.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class MyProductCell: UITableViewCell {

    var product:Product!
    
    @IBOutlet weak var Promotion: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Amount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    
    }
    func setByProduct(product:Product){
        self.product = product
        self.Amount.text = "数量:" + product.amount.toString()
        self.Price.text = "价格:" + product.price.toString()
        self.Promotion.text = "促销:" + product.promotion.toString()
    }
    

}
