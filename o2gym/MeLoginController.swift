//
//  MeLoginController.swift
//  o2gym
//
//  Created by xudongbo on 9/17/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class MeLoginController: UIViewController {

    @IBOutlet weak var loginView: LoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView.loginSuccessAction = self.showContentView
        
        if Local.HASLOGIN {
            self.loginView.hidden = true
            
        }
        
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool){
        if Local.HASLOGIN {
            self.showContentView()
        } 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showContentView(){
        let cont = MeViewController()
        cont.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(cont, animated: false)
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
