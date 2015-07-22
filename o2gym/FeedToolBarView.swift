//
//  WeiboToolBarView.swift
//  o2gym
//
//  Created by xudongbo on 7/21/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedToolBarView: UIView {
    @IBOutlet weak var HrHeight: NSLayoutConstraint!

    var fav:Bool = false
    var fwd:Bool = false
    var comment:Bool = false
    
    static let icons = [
        "fav": UIImage(named: "feed_fav"),
        "faved": UIImage(named: "feed_fav_active"),
        "fwd": UIImage(named: "feed_fwd"),
        "fwded": UIImage(named: "feed_fwd_active"),
        "comment": UIImage(named: "feed_comment"),
        "commented": UIImage(named: "feed_comment_active")
    ]
    
    @IBOutlet weak var FavIcon: UIImageView!
    @IBOutlet weak var FavNum: UILabel!
    
    
    @IBOutlet weak var FwdIcon: UIImageView!
    @IBOutlet weak var FwdNum: UILabel!
    
    @IBOutlet weak var CommentIcon: UIImageView!
    @IBOutlet weak var CommentNum: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var view: UIView!
    
    @IBAction func favPressed(sender: AnyObject) {
        self.fav = !self.fav
        if self.fav {
            self.FavIcon.image = FeedToolBarView.icons["faved"]!
            self.FavNum.textColor = O2Color.FavActive
        }
        else{
            self.FavIcon.image = FeedToolBarView.icons["fav"]!
            self.FavNum.textColor = O2Color.TextGrey
        }
    }
    
    
    @IBAction func commentPressed(sender: AnyObject) {
        self.comment = !self.comment
        if self.comment {
            self.CommentIcon.image = FeedToolBarView.icons["commented"]!
            self.CommentNum.textColor = O2Color.CommentActive
        }
        else{
            self.CommentIcon.image = FeedToolBarView.icons["comment"]!
            self.CommentNum.textColor = O2Color.TextGrey
        }
    }
    
    @IBAction func fwdPressed(sender: AnyObject) {
        self.fwd = !self.fwd
        if self.fwd {
            self.FwdIcon.image = FeedToolBarView.icons["fwded"]!
            self.FwdNum.textColor = O2Color.FwdActive
        }
        else{
            self.FwdIcon.image = FeedToolBarView.icons["fwd"]!
            self.FwdNum.textColor = O2Color.TextGrey
        }
    }
    
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
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
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        self.HrHeight.constant = 0.5
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "FeedToolBarView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    

}
