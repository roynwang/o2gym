//
//  WeiboToolBarView.swift
//  o2gym
//
//  Created by xudongbo on 7/21/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedFwdHeaderView: UIView, FeedHeaderProtocol {
    
    var nav:O2Nav?
    @IBOutlet weak var HrHeight: NSLayoutConstraint!
    @IBOutlet weak var Hr: UIView!
    @IBOutlet weak var Avatar: UIImageView!
    
    @IBOutlet weak var FwdDesc: UILabel!

    @IBOutlet weak var AuthorName: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    var view: UIView!
    
    var usrname: String!
    
    @IBAction func showDetail(sender: AnyObject) {
        O2Nav.showUser(self.usrname)
    }
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        //super.init()
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "FeedFwdHeaderView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        self.nav = O2Nav()
        return view
    }
    
    func fillHeader(weibo:Weibo) {
        let usr = weibo.fwdcontent!.author!
        self.usrname = usr.name
 
        self.Avatar.layer.cornerRadius = self.Avatar.frame.width/2
        self.Avatar.layer.masksToBounds = true
        self.Avatar.fitLoad(usr.avatar!, placeholder: UIImage(named:"avatar"))
//        self.Avatar.load(usr.avatar!, placeholder: UIImage(named:"avatar")) { (_, uiimg, errno_t) -> () in
//            if uiimg != nil {
//            self.Avatar.image = Helper.RBSquareImage(uiimg!)
//            }
//        }
        self.FwdDesc.text = weibo.by
        self.AuthorName.text = usr.displayname
        self.HrHeight.constant = 0.5

    }
    
}
