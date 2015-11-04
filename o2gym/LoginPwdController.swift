//
//  LoginPwdController.swift
//  o2gym
//
//  Created by xudongbo on 11/4/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class LoginPwdController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var HrHeight0: NSLayoutConstraint!
    @IBOutlet weak var HrHeight1: NSLayoutConstraint!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var Pwd: UITextField!
    @IBOutlet weak var Phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HrHeight0.constant = 0.5
        self.HrHeight1.constant = 0.5
        self.title = "登录"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "register")
        
        self.Pwd.delegate = self
        self.Phone.delegate = self
        self.navigationItem.hidesBackButton = true
     
        
        self.LoginBtn.backgroundColor = O2Color.Orange
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func register(){
        let cont = UIViewController()
        cont.title = "注册"
        cont.view = LoginView(frame: self.view.frame)
        self.navigationController?.pushViewController(cont, animated: true)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func Login(sender: AnyObject) {
        
        if self.Phone.text?.characters.count != 11 || self.Pwd.text == nil || self.Pwd.text == "" || self.Phone.text == "" {
            self.view.makeToast(message: "请输入正确的手机号和密码", duration: 2, position: HRToastPositionCenter)
            return
        } else {
            self.view.makeToastActivityWithMessage(message: "正在登录")
            Local.loginWithPwd(self.Phone.text!, password: self.Pwd.text!, onsuccess: { (_) -> Void in
                self.view.hideToastActivity()
                self.view.makeToast(message: "登录成功", duration: 2, position: HRToastPositionCenter)
                let delay = 1 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                    self.navigationController?.popViewControllerAnimated(true)
                })
                
                }, onfail: { (str) -> Void in
                    self.view.hideToastActivity()
                    self.view.makeToast(message: "登录失败，请输入正确的手机号和密码,", duration: 2, position: HRToastPositionCenter)
            })
            
            
        }
        
    }
    
    @IBAction func forgetPwd(sender: AnyObject) {
        let cont = UIViewController()
        cont.title = "重置密码"
        let lv = LoginView(frame: self.view.frame)
        lv.findPwd()
        cont.view = lv
        lv.loginSuccessAction = {
            let delay = 1 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
        
        self.navigationController?.pushViewController(cont, animated: true)
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
