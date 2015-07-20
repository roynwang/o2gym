//
//  RecommandArticleCell.swift
//  o2gym
//
//  Created by xudongbo on 7/12/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendArticleCell: BaseViewCell {


    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var UpCount: UILabel!
    @IBOutlet weak var ArticleTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setContent(item:BaseDataItem){
        let r = item as! RecommendItem
        let wb = r.recommendcontent as! Weibo
        
        if let font =  UIFont(name: "RTWS YueGothic Trial", size: 16) {
            
            let textFontAttributes = [
                NSFontAttributeName : font,
                // Note: SKColor.whiteColor().CGColor breaks this
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSStrokeColorAttributeName: UIColor.blackColor(),
                // Note: Use negative value here if you want foreground color to show
                NSStrokeWidthAttributeName: -1
            ]
            
            self.ArticleTitle.attributedText = NSMutableAttributedString(string: r.recommendtitle!, attributes: textFontAttributes)

        }
        //self.ArticleTitle.text = r.recommendtitle
        self.Img.load(r.recommendpic!)
        self.UpCount.text = wb.upnum.toString()
    }
    
}
