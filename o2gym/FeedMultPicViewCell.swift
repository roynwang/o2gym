//
//  FeedMultPicViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/22/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedMultPicViewCell: UITableViewCell {

    @IBOutlet weak var Bottom: FeedToolBarView!

    @IBOutlet weak var Header: UIView!
    

    @IBOutlet weak var HeaderHeight: NSLayoutConstraint!
    
    @IBOutlet weak var OriginHeader: FeedHeaderView!
    @IBOutlet weak var FwdHeader: FeedFwdHeaderView!
    
    @IBOutlet weak var ImgContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var CellContainer: UIView!
    
    @IBOutlet weak var ImgContainer: UIScrollView!
    @IBOutlet weak var Brief: UILabel!
    
    var PicWidth : CGFloat = 0
    var NextX : CGFloat = 0
    var Spacing : CGFloat = 2
    var headcontent:FeedHeaderProtocol!

    
    var imgs:[UIImageView] = []
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        //self.HrHeight.constant = 0.5
        // Initialization code
        self.CellContainer.layer.borderWidth = 0.5
        self.CellContainer.layer.borderColor = O2Color.BorderGrey.CGColor
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.ImgContainer.scrollsToTop = false
        
        //self.ImgContainerHeight.constant = 150
        
        self.NextX += self.Spacing

        println(self.ImgContainer.frame.width)

        self.PicWidth = UIScreen.mainScreen().bounds.width - 20
        println(self.PicWidth)
        self.ImgContainerHeight.constant = self.PicWidth
        
//        for view in self.Header.subviews {
//            println("removeing")
//            view.removeFromSuperview()
//        }
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
    

    func addPic(img:String){
        let tmp:UIImageView = UIImageView()
        tmp.frame = CGRect(x: self.NextX, y: 0, width: self.PicWidth, height: self.PicWidth)
        self.imgs.append(tmp)
        self.ImgContainer.addSubview(tmp)
        
        tmp.load(img, placeholder: nil, completionHandler:
            { (_, uiimg, _) in
                tmp.image = Helper.RBSquareImage(uiimg!)
        })
        
        self.NextX += self.PicWidth
        self.NextX += self.Spacing
        self.ImgContainer.contentSize.width = self.NextX
        
    }
    func emptyPic(){
        for view in self.ImgContainer.subviews {
            let tmp = view as! UIImageView
            tmp.removeFromSuperview()
        }
        self.imgs = []
        self.NextX = self.Spacing
    }
    
    func fillCard(ori:Weibo){
        self.setFwd(ori.isfwd)
        
        self.fillHeader(ori)
        self.fillBottom(ori)
        
        let weibo = ori.isfwd ? ori.fwdcontent! : ori
       
        self.emptyPic()
        for pic in weibo.img_set {
            self.addPic(pic)
        }
        self.Brief.attributedText = weibo.title.getCustomLineSpaceString(2)
    }
    func fillHeader(weibo:Weibo){
        //self.headcontent = nil
        self.headcontent.fillHeader(weibo)
    }
    func fillBottom(weibo:Weibo){
        self.Bottom.setContent(weibo)
    }
    
}
