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
    
    
    var isFind:Bool = false
    
    @IBOutlet weak var Agreement: UIButton!
    
    var view: UIView!
    
    @IBOutlet weak var Pwd: UITextField!
    @IBOutlet weak var PwdCheck: UITextField!
    @IBOutlet weak var CheckBox: CTCheckbox!
    @IBOutlet weak var HrHeight2: NSLayoutConstraint!
    @IBOutlet weak var HrHeight1: NSLayoutConstraint!
    @IBOutlet weak var HrHeight0: NSLayoutConstraint!
    @IBOutlet weak var LoginWithPhoneBtn: UIButton!
    @IBOutlet weak var SendSms: JKCountDownButton!
    @IBOutlet weak var Vcode: UITextField!
    @IBOutlet weak var PhoneNum: UITextField!
    var loginSuccessAction:(()->Void)!
    


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
//        self.determineLoginMethod()
//        self.HrHeight.constant = 0.5
        self.CheckBox.addTarget(self, action: "checkboxChanged", forControlEvents: UIControlEvents.ValueChanged)
        self.CheckBox.checked = true
        self.CheckBox.textLabel.text = "我已同意"
        self.CheckBox.textLabel.font = UIFont(name: "Avenir", size: 12)
        self.CheckBox.textLabel.textColor = UIColor.lightGrayColor()
        self.CheckBox.setColor(UIColor.lightGrayColor(), forControlState: UIControlState.Normal)
        self.CheckBox.setColor(O2Color.OkGreen, forControlState: UIControlState.Selected)
        self.CheckBox.setColor(UIColor.lightGrayColor(), forControlState: UIControlState.Disabled)
        
        
        
        self.CheckBox.checkboxColor = O2Color.OkGreen
        
        self.HrHeight0.constant = 0.5
        self.HrHeight1.constant = 0.5
        self.HrHeight2.constant = 0.5
        addSubview(view)
    }
    
    func checkboxChanged(){
        if self.CheckBox.checked {
            self.CheckBox.checkboxColor = O2Color.OkGreen
            self.CheckBox.textLabel.textColor = UIColor.lightGrayColor()
            self.LoginWithPhoneBtn.backgroundColor = O2Color.Orange
            self.LoginWithPhoneBtn.userInteractionEnabled = true
        } else {
//            self.CheckBox.checkboxColor = UIColor.lightGrayColor()
            self.CheckBox.textLabel.textColor = UIColor.lightGrayColor()
            self.LoginWithPhoneBtn.backgroundColor = O2Color.BorderThick
            self.LoginWithPhoneBtn.userInteractionEnabled = false
        }
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LoginView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
        
    }
    
    func findPwd(){
        self.isFind = true
        self.CheckBox.hidden = true
        self.Agreement.hidden = true
    }
    
    
    func determineLoginMethod(){
        
        self.PhoneNum.delegate = self
        self.Vcode.delegate = self
        self.Pwd.delegate = self
        self.PwdCheck.delegate = self
        
        
//        print(WXApi.isWXAppInstalled())
//        print(WXApi.isWXAppSupportApi())
//        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupportApi() {
//            self.LoginBtn.hidden = false
//            self.PhoneLoginView.hidden = true
//        }
        
    }
    
    
    @IBAction func loginWithVcode() {
        if self.PhoneNum.text?.characters.count != 11 || self.Vcode.text?.characters.count !=  6{
            self.view.makeToast(message: "请输入正确的手机号和验证码", duration: 2, position: HRToastPositionCenter)
            return
        }
        if self.Pwd.text! != self.PwdCheck.text! {
            self.view.makeToast(message: "您输入的密码不一致，请重新输入", duration: 2, position: HRToastPositionCenter)
            return
        }
        
        if self.Pwd.text!.rangeOfString("^[_!@#$&*A-Za-z0-9]{8,16}$", options: .RegularExpressionSearch) == nil {
            self.view.makeToast(message: "密码必须为8-16位的符号(_!@#$&*)，数字和字母的组合", duration: 2, position: HRToastPositionCenter)
            return
        }
        
        
        //self.endEditing(true)
        self.textFieldShouldEndEditing(self.PhoneNum)
        self.textFieldShouldEndEditing(self.Vcode)
        self.textFieldShouldEndEditing(self.Pwd)
        self.textFieldShouldEndEditing(self.PwdCheck)
        Local.loginWithVcode(self.PhoneNum.text!, vcode: self.Vcode.text!, pwd: self.Pwd.text!, onsuccess: { (_) -> Void in
            if self.isFind {
                self.makeToast(message: "密码设置成功")
            } else {
                self.makeToast(message: "账号创建成功")
            }
            if self.loginSuccessAction != nil {
                self.loginSuccessAction!()
            }
            }, onfail: { (str) -> Void in
                self.view.makeToast(message: "登录失败，请检查验证码或手机号码", duration: 2, position: HRToastPositionCenter)
        })
    }
    
    @IBAction func sendVcode(sender: AnyObject) {
        if self.PhoneNum.text?.characters.count != 11 {
            self.view.makeToast(message: "请输入正确的手机号", duration: 2, position: HRToastPositionCenter)
            return
        }

        self.SendSms.startWithSecond(90)
        self.SendSms.setTitle("验证码已发送", forState: UIControlState.Normal)
        self.SendSms.didChange { (btn, second) -> String! in
            return "\(second)秒后重发"
        }
        self.SendSms.userInteractionEnabled = false
        self.SendSms.alpha = 0.5
        
        self.SendSms.didFinished { (btn, second) -> String! in
            self.SendSms.userInteractionEnabled = true
            self.SendSms.alpha = 1
            return "重新获取"
        }
        
        
        
        Alamofire.request(.POST, Host.VcodeSend(), parameters:["number": self.PhoneNum.text!])
            .responseJSON { (req, resp, data) -> Void in
                return
        }
    }
    
    @IBAction func showProtocol(sender: AnyObject) {
        O2Nav.showProtocol()
    }

    
    @IBAction func loginWithWeChat() {
        print("xxxxx")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func phoneEditing(sender: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
