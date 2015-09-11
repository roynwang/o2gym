//
//  FirstViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var Pwd: UITextField!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var GoNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginIndicator.hidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Login(sender: UIButton) {
        self.loginIndicator.hidden = false
        self.loginIndicator.startAnimating()
        let name = self.UserName.text
        if !name.isEmpty {
            let pwd = self.Pwd.text
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(name, forKey: "o2gym_name")
            if !pwd.isEmpty {
                defaults.setObject(pwd, forKey: "o2gym_pwd")
            }
        }
        func onsuccess(usr:User){
            dispatch_async(dispatch_get_main_queue()) {
                print("===loading user========\n")
                self.loginIndicator.stopAnimating()
                self.loginIndicator.hidden = true
                Local.FEED = Feed()
                func showmain(){
                      //dispatch_async(dispatch_get_main_queue()) {
                        let v = self.storyboard?.instantiateViewControllerWithIdentifier("mainview") as! UITabBarController
                     
                        self.presentViewController(v, animated: true, completion: nil)
                    
                    //}
                }
                Local.FEED?.load(showmain, itemcallback: nil)
                Local.RECOMMEND = RecommendList()
              
                
                print("============")
            }
        }
        func onfail(msg:String){
            dispatch_async(dispatch_get_main_queue()) {
                print("============")
                self.loginIndicator.stopAnimating()
                self.loginIndicator.hidden = true
                print(msg)
                print("============")
            }
        }
        Local.login(onsuccess, onfail: onfail)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
