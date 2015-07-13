//
//  FirstViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    @IBOutlet weak var subtext: UILabel!
    let usr:User = Local.USER
    func refreshTitle(usr:User)->Void{
        let tmp = usr
        
        dispatch_async(dispatch_get_main_queue()) {
            self.subtext.text = tmp.id!.toString()
        }
        print(tmp.id)
    }
    func t(weibo:Weibo){
        print(weibo.title)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        dispatch_async(dispatch_get_main_queue()) {
//            let t = self.usr.id!.toString()
//            print(self.usr.id!.toString())
//            self.subtext.text = t
//        }
        //let feed:Feed = Feed()
        //feed.load(t)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

