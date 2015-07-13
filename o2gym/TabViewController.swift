//
//  TabViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/10/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    var weiboid:Int? = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "comments"{
            let cl = segue.destinationViewController as! CommentViewController
            cl.weiboid = self.weiboid
        }
    }
}
