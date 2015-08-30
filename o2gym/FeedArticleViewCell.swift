//
//  FeedArticleViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/23/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedArticleViewCell: UITableViewCell {

    @IBOutlet weak var TimeLine: UIView!
    @IBOutlet weak var Month: UILabel!
    @IBOutlet weak var Day: UILabel!
    @IBOutlet weak var TimeLineWidth: NSLayoutConstraint!
    @IBOutlet weak var BottomHeight: NSLayoutConstraint!
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
        self.backgroundColor = O2Color.BgGreyColor
         self.TimeLine.backgroundColor = O2Color.BgGreyColor
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
    func fillCard(ori:Weibo, isSelf:Bool = false, timeline:[Int]? = nil){
        
        self.setFwd(ori.isfwd)
        self.fillHeader(ori)
        if isSelf {
            self.Bottom.hidden = true
            self.BottomHeight.constant = 0
            
        }
        else {
            self.fillBottom(ori)
            self.Bottom.hidden = false
            self.BottomHeight.constant = 40
        }
        
        if timeline == nil {
            self.TimeLine.hidden = true
            self.TimeLineWidth.constant = 0
        } else {
            self.TimeLine.hidden = false
            self.TimeLineWidth.constant = 43
            if timeline?.count == 0 {
                self.Day.text = ""
                self.Month.text = ""
            } else {
                self.Day.text = timeline![0].toString()
                self.Month.text = timeline![1].toString() + "月"
            }

        }

        
        let weibo = ori.isfwd ? ori.fwdcontent! : ori
        
        self.Title.text = weibo.title
        self.Brief.text = weibo.brief
        if weibo.img_set.count > 0 {
        self.Img.load(weibo.img_set[0], placeholder: UIImage(named:"avatar")) { (_, uiimg, errno_t) -> () in
            self.Img.image = Helper.RBSquareImage(uiimg!)
        }
        }
    }
    func fillHeader(weibo:Weibo){
        //self.headcontent = nil
        self.headcontent.fillHeader(weibo)
    }
    func fillBottom(weibo:Weibo){
        self.Bottom.setContent(weibo)
    }

    
}
