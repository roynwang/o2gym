//
//  FeedArticleViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/23/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedArticleViewCell: UITableViewCell {

    @IBOutlet weak var FwdHeader: FeedFwdHeaderView!
    @IBOutlet weak var OriginHeader: FeedHeaderView!
    @IBOutlet weak var HeaderHeight: NSLayoutConstraint!
    @IBOutlet weak var Bottom: FeedToolBarView!
    @IBOutlet weak var Header: UIView!
    @IBOutlet weak var Brief: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Container: UIView!
    
    var headcontent:FeedHeaderProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Container.layer.borderWidth = 0.5
        self.Container.layer.borderColor = O2Color.BorderGrey.CGColor
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.Title.textColor = O2Color.TextBlack
        self.Brief.textColor = O2Color.TextGrey
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setFwd(isFwd: Bool){
        if !isFwd {
            self.HeaderHeight.constant = 46
            self.FwdHeader.hidden = true
            self.OriginHeader.hidden = false
            self.headcontent = self.OriginHeader
        }
        else{
            self.HeaderHeight.constant = 80
            self.FwdHeader.hidden = false
            self.OriginHeader.hidden = true
            self.headcontent = self.FwdHeader
        }
    }
    func fillCard(ori:Weibo){
        
        self.setFwd(ori.isfwd)
        self.fillHeader(ori)
        self.fillBottom(ori)
        
        let weibo = ori.isfwd ? ori.fwdcontent! : ori
        
        self.Title.text = weibo.title
        self.Brief.text = weibo.brief
        self.Img.load(weibo.img_set[0])
    }
    func fillHeader(weibo:Weibo){
        //self.headcontent = nil
        self.headcontent.fillHeader(weibo)
    }
    func fillBottom(weibo:Weibo){
        self.Bottom.setContent(weibo)
    }

    
}
