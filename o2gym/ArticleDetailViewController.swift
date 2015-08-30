//
//  ArticalDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 8/24/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var Avatar: UIImageView!
    var weiboid:Int!
    var faved:Bool = false
    var author:User!
    static let imgfav = UIImage(named:"fav_bar")
    static let imgfav_active = UIImage(named: "fav_bar_active")

    @IBOutlet weak var TopInset: NSLayoutConstraint!
    @IBOutlet weak var ArticleTitle: UILabel!

    @IBOutlet weak var FollowBtn: UIButton!
    @IBOutlet weak var ArticleDetail: UIWebView!
    var favbtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.FollowBtn.layer.borderColor = O2Color.MainColor.CGColor
        self.FollowBtn.layer.cornerRadius = 3
        self.FollowBtn.layer.masksToBounds = true
        self.FollowBtn.layer.borderWidth=1
        
        self.Avatar.layer.cornerRadius = self.Avatar.frame.width/2
        self.Avatar.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.leftBarButtonItems = [Helper.createBarButtonItemFromImg("back", selector: "back", tar: self)]
        
        //usr.loadRemote(header.setContent, onfail: nil)
        
        var favimgname = "fav_bar"
        
        
        if let index = find(Local.USER.upped, self.weiboid){
            self.faved = true
            favimgname = "fav_bar_active"
        }
        self.favbtn = Helper.createButtonFromImg(favimgname, selector: "favarticle", tar: self)
        
        
        self.navigationItem.rightBarButtonItems = [
            Helper.createBarButtonItemFromImg("fwd_bar", selector: "fwdarticle", tar: self),
            UIBarButtonItem(customView: self.favbtn)
        ]
        //self.navigationController?.navigationBar.translucent = false
        //O2Nav.resetNav()
        //O2Nav.setNavigationBarTransformProgress(1)

        
        
        
        self.ArticleDetail.scalesPageToFit = true
        self.ArticleDetail.scrollView.bounces = false
        //let testreq:NSURLRequest = NSURLRequest(URL: NSURL(string: "http://www.163.com")!)
        let testreq:NSURLRequest = NSURLRequest(URL: NSURL(string: Host.ArticleGet(self.weiboid))!)
        self.ArticleDetail.loadRequest(testreq)
        
        
        let weibo = Weibo(weiboid: self.weiboid)
        weibo.loadRemote({ (data) -> Void in
            let wb = data as! Weibo
            self.Avatar.load(wb.usr.avatar!, placeholder: UIImage(named:"avatar")) { (_, uiimg, errno_t) -> () in
                self.Avatar.image = Helper.RBSquareImage(uiimg!)
            }
            self.ArticleTitle.text = wb.title
            self.author = wb.usr
            
            if let i = find(Local.TIMELINE.follows, self.author.id!) {
                self.FollowBtn.hidden = true
            }
          
        }, onfail: nil)
    }
    
    @IBAction func follow(sender: AnyObject) {
        Local.USER.follow(self.author.name!, onsuccess: { () -> Void in
            Local.TIMELINE.follows.append(self.author.id!)
            self.FollowBtn.hidden = true
        })
        
    }
    override func viewWillAppear(animated: Bool) {
        //O2Nav.resetNav()
        O2Nav.setController(self)
        O2Nav.nav?.translucent = false
        //O2Nav.setNavigationBarTransformProgress(1)
    }
    
    @IBAction func toAuthor(sender: AnyObject) {
        O2Nav.showUser(self.author.name!)
    }
        
    func back()
    {
        //O2Nav.setNavigationBarTransformProgress(0)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
   
    
    func favarticle(){
        self.faved = !self.faved
        let wb = Weibo(weiboid: self.weiboid)
        if self.faved{
            self.favbtn.setImage(ArticleDetailViewController.imgfav_active, forState: UIControlState.Normal)
            Local.USER.upped.append(self.weiboid)
            wb.up(true)
        }
        else{
            self.favbtn.setImage(ArticleDetailViewController.imgfav, forState: UIControlState.Normal)
            if let index = find(Local.USER.upped, self.weiboid) {
                Local.USER.upped.removeAtIndex(index)
            }
            wb.up(false)
        }
    }
    
    func fwdarticle(){
        let wb = Weibo(usr: Local.USER, weiboid: self.weiboid)
        wb.fwd(Local.USER, onsuccess: nil, onfail: nil)
        //wb.fwd(<#usr: User#>, onsuccess: <#((Weibo) -> Void)?##(Weibo) -> Void#>, onfail: <#((NSError?) -> Void)?##(NSError?) -> Void#>)
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
