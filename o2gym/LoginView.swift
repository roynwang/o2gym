//
//  LoginView.swift
//  o2gym
//
//  Created by xudongbo on 9/17/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

@IBDesignable class LoginView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var LoginWithPhoneBtn: UIButton!
    @IBOutlet weak var SendSms: UIButton!
    @IBOutlet weak var Vcode: UITextField!
    @IBOutlet weak var PhoneNum: UITextField!
    @IBOutlet weak var PhoneLoginView: UIView!
    var loginSuccessAction:(()->Void)!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    
    
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
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LoginView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
        
    }
    
    
    
    func determineLoginMethod(){
        println(WXApi.isWXAppInstalled())
        println(WXApi.isWXAppSupportApi())
        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupportApi() {
            self.LoginBtn.hidden = false
            self.PhoneLoginView.hidden = true
        }
        
    }
    
    
    @IBAction func loginWithVcode() {
        Local.loginWithVcode(self.PhoneNum.text, vcode: self.Vcode.text, onsuccess: { (_) -> Void in
            if self.loginSuccessAction != nil {
                self.loginSuccessAction!()
            }
            }, onfail: nil)
    }
    
    @IBAction func sendVcode(sender: AnyObject) {
        request(.POST, Host.VcodeSend(), parameters:["number": self.PhoneNum.text!])
            .responseJSON { (req, resp, data, err) -> Void in
                return
        }
    }
    
    
    @IBAction func loginWithWeChat() {
        println("xxxxx")
    }
    
    
}
