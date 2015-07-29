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
    var weibo:Weibo!
    
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
            self.weibo.up()
            self.action("fav")

        }
        else{
            println(Local.USER.upped)
            self.weibo.up(false)
            self.action("fav", active: false)
            println(Local.USER.upped)
    
        }
    }

    
    func updateLabel(label:UILabel, value:Int){
        dispatch_async(dispatch_get_main_queue()){
            label.text = value.toString()
        }
    }
    
    func action(action:String, active:Bool = true){
        switch(action){
        case "fav":
            if active {
                self.fav = true
                self.FavIcon.image = FeedToolBarView.icons["faved"]!
                self.FavNum.textColor = O2Color.FavActive

            }else{
                self.fav = false
                self.FavIcon.image = FeedToolBarView.icons["fav"]!
                self.FavNum.textColor = O2Color.TextGrey
                
            }
            if self.weibo != nil {self.updateLabel(self.FavNum, value: self.weibo.upnum)}
            break
        case "fwd":
            if active {
                self.FwdIcon.image = FeedToolBarView.icons["fwded"]!
                self.FwdNum.textColor = O2Color.FwdActive
                Local.USER.fwded.append(self.weibo.id!)
            } else {
                self.FwdIcon.image = FeedToolBarView.icons["fwd"]!
                self.FwdNum.textColor = O2Color.TextGrey
            }
            if self.weibo != nil {self.updateLabel(self.FwdNum, value: self.weibo.fwdnum)}
            break
        case "comment":
            if active {
                self.CommentIcon.image = FeedToolBarView.icons["commented"]!
                self.CommentNum.textColor = O2Color.CommentActive
            } else {
                self.CommentIcon.image = FeedToolBarView.icons["comment"]!
                self.CommentNum.textColor = O2Color.TextGrey
            }
            if self.weibo != nil {self.updateLabel(self.CommentNum, value: self.weibo.commentnum)}
            break
        default:
            break
        }
    }
    
    @IBAction func commentPressed(sender: AnyObject) {
        //self.comment = !self.comment
        self.weibo.loadRemote(self.setContent, onfail: nil)
    }
    
    @IBAction func fwdPressed(sender: AnyObject) {
        if !self.fwd {
//            if self.weibo.isfwd {
//                self.weibo.fwdcontent!.fwd(Local.USER, onsuccess:nil, onfail:nil)
//            } else {
                self.weibo.fwd(Local.USER, onsuccess:nil, onfail:nil)
                self.weibo.fwdnum += 1
                self.action("fwd")
//            }
        }
        //self.weibo.loadRemote(self.setContent, onfail: nil)
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
    func reset(){
        self.action("fav", active: false)
        self.action("fwd", active: false)
        self.action("comment", active: false)
    }
    
    func setContent(weibo:Weibo){
        //self.reset()
        self.weibo = weibo

        if let index = find(Local.USER.upped, weibo.id!) {
            self.action("fav")
        } else {
            self.action("fav", active: false)
        }
        if let index = find(Local.USER.fwded, weibo.id!) {
            self.action("fwd")
        } else {
            self.action("fwd", active: false)
        }
        if let index = find(Local.USER.commented, weibo.id!) {
            self.action("comment")
        } else {
            self.action("comment", active: false)
        }
    }
}
