//
//  CoachDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class CoachDetailViewController: UIViewController {
    
    var coach:User? = nil

    @IBOutlet weak var avatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.coach!.name
        self.avatar.load(self.coach!.avatar!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
