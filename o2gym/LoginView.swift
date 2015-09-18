//
//  LoginView.swift
//  o2gym
//
//  Created by xudongbo on 9/17/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit
import Alamofire

@IBDesignable class LoginView: UIView, UITextFieldDelegate {
    
    var view: UIView!
    
    @IBOutlet weak var LoginWithPhoneBtn: UIButton!
    @IBOutlet weak var SendSms: JKCountDownButton!
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
    
    required init?(coder aDecoder: NSCoder) {
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
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        self.determineLoginMethod()
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
        
        self.SendSms.enabled = false
        self.LoginBtn.enabled = false
        self.PhoneNum.delegate = self
        self.Vcode.delegate = self
        
        
//        print(WXApi.isWXAppInstalled())
//        print(WXApi.isWXAppSupportApi())
//        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupportApi() {
//            self.LoginBtn.hidden = false
//            self.PhoneLoginView.hidden = true
//        }
        
    }
    
    
    @IBAction func loginWithVcode() {
        Local.loginWithVcode(self.PhoneNum.text!, vcode: self.Vcode.text!, onsuccess: { (_) -> Void in
            if self.loginSuccessAction != nil {
                self.loginSuccessAction!()
            }
            }, onfail: nil)
    }
    
    @IBAction func sendVcode(sender: AnyObject) {
        self.SendSms.startWithSecond(90)
        self.SendSms.titleLabel?.text = "已发送"
        self.SendSms.didChange { (btn, second) -> String! in
            return "\(second)秒"
        }
        self.SendSms.enabled = false
        self.SendSms.alpha = 0.5
        
        self.SendSms.didFinished { (btn, second) -> String! in
            self.SendSms.enabled = true
            self.SendSms.alpha = 1
            return "重新获取"
        }
        
        
        
        Alamofire.request(.POST, Host.VcodeSend(), parameters:["number": self.PhoneNum.text!])
            .responseJSON { (req, resp, data) -> Void in
                return
        }
    }
    
    
    @IBAction func loginWithWeChat() {
        print("xxxxx")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func phoneEditing(sender: UITextField) {
        
        if sender.text != nil && sender.text!.characters.count == 11 {
            self.SendSms.enabled = true
            self.LoginBtn.enabled = true
        } else {
            self.SendSms.enabled = false
            self.LoginBtn.enabled = false
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
