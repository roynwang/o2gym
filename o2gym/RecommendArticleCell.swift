//
//  RecommandArticleCell.swift
//  o2gym
//
//  Created by xudongbo on 7/12/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendArticleCell: UITableViewCell {

    @IBOutlet weak var Desc: UILabel!
    @IBOutlet weak var BriefImage: UIImageView!
    var t:String = "haha"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.Desc.text = t
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setContent(item:BaseDataItem){
        let weibo = item as! Weibo
        self.Desc.text = weibo.title
        self.BriefImage.load(weibo.img_set[0])
    }
    
}
