//
//  FeedMultPicViewCell.swift
//  o2gym
//
//  Created by xudongbo on 7/22/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedMultPicViewCell: UITableViewCell {
    
    @IBOutlet weak var TimeLine: UIView!
    @IBOutlet weak var Bottom: FeedToolBarView!
    
    @IBOutlet weak var Header: UIView!
    
    
    @IBOutlet weak var HeaderHeight: NSLayoutConstraint!
    @IBOutlet weak var TimeLineWidth: NSLayoutConstraint!
    @IBOutlet weak var BottomHeight: NSLayoutConstraint!
    @IBOutlet weak var OriginHeader: FeedHeaderView!
    @IBOutlet weak var FwdHeader: FeedFwdHeaderView!
    
    @IBOutlet weak var ImgContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var CellContainer: UIView!
    
    @IBOutlet weak var ImgContainer: UIScrollView!
    @IBOutlet weak var Brief: UILabel!
    
    @IBOutlet weak var Day: UILabel!
    @IBOutlet weak var Month: UILabel!
    
    
    
    var PicWidth : CGFloat = 0
    var NextX : CGFloat = 0
    var Spacing : CGFloat = 2
    var headcontent:FeedHeaderProtocol!
    
    
    var imgs:[UIImageView] = []
    var photos:[PicForNYT] = []
    
    
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
    
    
    func addPic(img:String){
        let tmp:UIImageView = UIImageView()
        tmp.frame = CGRect(x: self.NextX, y: 0, width: self.PicWidth, height: self.PicWidth)
        self.imgs.append(tmp)
        self.ImgContainer.addSubview(tmp)
        
        let tapped = UITapGestureRecognizer()
        tapped.addTarget(self, action: Selector("showBrowser:"))
        tapped.delegate = self
        tmp.addGestureRecognizer(tapped)
        
        
        tmp.load(img, placeholder: nil, completionHandler:
            { (_, uiimg, _) in
                
                tmp.image = Helper.RBSquareImage(uiimg!)
                //tmp.addGestureRecognizer(tapped)
        })
        
        self.NextX += self.PicWidth
        self.NextX += self.Spacing
        self.ImgContainer.contentSize.width = self.NextX
        self.ImgContainer.addGestureRecognizer(tapped)
        
        
        let pnyt = PicForNYT(url:NSURL(string: img),attributedCaptionTitle: NSAttributedString(string: "",attributes: [NSForegroundColorAttributeName: UIColor.grayColor()]))
        self.photos.append(pnyt)
        
    }
    func emptyPic(){
        for view in self.ImgContainer.subviews {
            let tmp = view as! UIImageView
            tmp.removeFromSuperview()
        }
        self.imgs = []
  
        self.photos = []
        self.NextX = self.Spacing
    }
    func showBrowser(sender:UITapGestureRecognizer){
        
        let xoffset = self.ImgContainer.contentOffset.x
        let cursor = sender.locationInView(self.ImgContainer)
        var index = 0
        for i in 0..<self.imgs.count {
            if self.PicWidth > (cursor.x - self.imgs[i].frame.origin.x)  && (cursor.x - self.imgs[i].frame.origin.x) > 0 {
                index = i
                break
            }
        }
        
        
        //let index:Int = find(self.imgs, sender.view as! UIImageView)!
        
        let photosViewController = NYTPhotosViewController(photos: photos, initialPhoto: photos[index] as NYTPhoto)
        
        photosViewController.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        O2Nav.controller.navigationController?.presentViewController(photosViewController, animated: true, completion: nil)
        
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
            self.PicWidth = UIScreen.mainScreen().bounds.width - 20
        } else {
            self.TimeLine.hidden = false
            self.TimeLineWidth.constant = 43
            self.PicWidth = UIScreen.mainScreen().bounds.width - 20 - 43
            if timeline?.count == 0 {
                self.Day.text = ""
                self.Month.text = ""
            } else {
                self.Day.text = timeline![0].toString()
                self.Month.text = timeline![1].toString() + "月"
            }
        }
        
        let weibo = ori.isfwd ? ori.fwdcontent! : ori
        
        
        
        
        self.ImgContainerHeight.constant = self.PicWidth
        
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
