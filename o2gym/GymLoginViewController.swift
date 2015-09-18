//
//  FirstViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class GymLoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: LoginView!
    var loginSuccess:(()->Void)!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Local.HASLOGIN {
            self.loginView.hidden = true
        }
        
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    override func viewDidAppear(animated: Bool) {
        if Local.HASLOGIN {
            let cont = GymNowController()
            cont.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(cont, animated: false)
        }
    }
    
    
    func showContentView(){
        let cont = GymNowController()
        cont.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(cont, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
//    @IBAction func Login(sender: UIButton) {
//        self.loginIndicator.hidden = false
//        self.loginIndicator.startAnimating()
//        let name = self.UserName.text
//        if !name.isEmpty {
//            let pwd = self.Pwd.text
//            let defaults = NSUserDefaults.standardUserDefaults()
//            defaults.setObject(name, forKey: "o2gym_name")
//            if !pwd.isEmpty {
//                defaults.setObject(pwd, forKey: "o2gym_pwd")
//            }
//        }
//        func onsuccess(usr:User){
//            dispatch_async(dispatch_get_main_queue()) {
//                print("===loading user========\n")
//                self.loginIndicator.stopAnimating()
//                self.loginIndicator.hidden = true
//                if self.loginSuccess != nil {
//                    self.loginSuccess!()
//                }
//                print("============")
//            }
//        }
//        func onfail(msg:String){
//            dispatch_async(dispatch_get_main_queue()) {
//                print("============")
//                self.loginIndicator.stopAnimating()
//                self.loginIndicator.hidden = true
//                print(msg)
//                print("============")
//            }
//        }
//        Local.login(onsuccess, onfail: onfail)
//    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
