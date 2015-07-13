//
//  WeiboViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/8/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class WeiboViewController: UIViewController {
    
   
    @IBOutlet weak var CommentContainer: UIView!
    @IBOutlet weak var ScrollRect: UIScrollView!
    var weibo:Weibo? = nil

    @IBOutlet weak var WeiboContent: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.weibo = Local.FEED?.datalist[self.dataid!] as? Weibo
        self.WeiboContent.text = weibo!.title
        
        self.ScrollRect.contentSize = CGSize(width: 400, height: 800)
        // Do any additional setup after loading the view.
        self.CommentContainer.frame = CGRect(x: self.CommentContainer.frame.origin.x,
            y: self.CommentContainer.frame.origin.y,
            width: self.CommentContainer.frame.size.width,
            height: 50*20)
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
        if segue.identifier == "tabs"{
            let cl = segue.destinationViewController as! TabViewController
            cl.weiboid = self.weibo!.id
        }
    }

}
