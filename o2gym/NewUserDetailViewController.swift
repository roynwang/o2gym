//
//  NewUserDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/7/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class NewUserDetailViewController: RYProfileViewController, CMPopTipViewDelegate {
    //var mypost:MyPostViewController!
    var album:AlbumViewController!
    var mycourse:MyGoodsViewController!
    var mycomments:UserCommentListController!
    var usrname:String = ""
    var usr : User!
    var favbtn:UIButton!
    static let imgfav = UIImage(named:"fav_bar")
    static let imgfav_active = UIImage(named: "fav_bar_active")
    var faved:Bool = false
    
    var reportView:CMPopTipView!
    
    var header:UserDetailHeaderView!

    override func viewDidLoad() {
        
//        self.mypost = MyPostViewController(nibName: "MyPostViewController", bundle: nil, usrname:self.usrname)
//        self.mypost.rydelegate = self
        
        
        
        self.album = AlbumViewController(nibName: "AlbumViewController", bundle: nil)
        self.album.rydelegate = self
        self.album.usrname = self.usrname
        self.album.parent = self
        
        self.mycourse = MyGoodsViewController(nibName: "MyPostViewController", bundle: nil, usrname:self.usrname)
        self.mycourse.rydelegate = self
        self.mycourse.parent = self
        

        self.viewControllerSet = [album,mycourse]
        self.header = self.initHeaderView()
        self.headerView = self.header
        self.segmentControlView = self.initSeg()
    
        self.usr = User(name: self.usrname)
        
        super.viewDidLoad()
        
        self.view.backgroundColor = O2Color.MainColor
        
        // Do any additional setup after loading the view.
        
        let addbtn = UIBarButtonItem(image: UIImage(named: "setting"), style: UIBarButtonItemStyle.Plain, target: self, action: "showSetting")
        let morebtn = UIBarButtonItem(image: UIImage(named: "more")?.add_tintedImageWithColor(UIColor.whiteColor(), style: ADDImageTintStyleKeepingAlpha), style: UIBarButtonItemStyle.Plain, target: self, action: "showMore")
        
        let reportbtn = UIButton(frame: CGRectMake(0,0,60,20))
        reportbtn.setTitle("举报", forState: UIControlState.Normal)
        reportbtn.titleLabel?.text = "举报"
        reportbtn.backgroundColor = UIColor.darkGrayColor()
        reportbtn.titleLabel?.textColor = UIColor.whiteColor()
        reportbtn.addTarget(self, action: "reportIllegal", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        reportView = CMPopTipView(customView: reportbtn)
        reportView.backgroundColor = UIColor.darkGrayColor()
        reportView.borderColor = UIColor.darkGrayColor()
        reportView.has3DStyle = false
        reportView.dismissTapAnywhere = true
        reportView.hasGradientBackground = false
        reportView.delegate = self
        
        if Local.HASLOGIN && self.usr.name == Local.USER.name {
//            self.navigationItem.rightBarButtonItem =
            self.navigationItem.rightBarButtonItems = [addbtn]
        } else {
            self.navigationItem.rightBarButtonItems = [morebtn]
        }
    }
    
    func showSetting(){
        let cont = ProfileViewController(style: UITableViewStyle.Grouped)
        cont.hidesBottomBarWhenPushed = true
        O2Nav.pushViewController(cont)
    }
    func showMore(){
        self.reportView.presentPointingAtBarButtonItem(self.navigationItem.rightBarButtonItems![0], animated: true)
    }
    func reportIllegal(){
        self.reportView.dismissAnimated(true)
        let alert = SIAlertView(title: "举报", andMessage: "确定该用户资料中有不当内容吗？")
        alert.addButtonWithTitle("取消", type: .Cancel) { (_) -> Void in
            alert.dismissAnimated(true)
        }
        alert.addButtonWithTitle("确定", type: SIAlertViewButtonType.Default, handler: { (_) -> Void in
            alert.dismissAnimated(true)
            self.view.makeToast(message: "已经提交了对该用户的举报")
        })

        alert.show()
    }
    
    
    func recommendperson(){
        let wb = Weibo(usr: Local.USER)
        wb.recommendUser(self.usr, onsuccess: nil, onfail: nil)
    }
    
    func showGym(gr:UITapGestureRecognizer){
        O2Nav.showGym(gr.view!.tag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        O2Nav.setController(self)
    }
    
    func initHeaderView()->UserDetailHeaderView {
        let header = UserDetailHeaderView()
        let ret = header.loadViewFromNib() as! UserDetailHeaderView
        ret.frame = CGRectMake(0,0, self.view.frame.width, self.headerHeight)
        return ret
    }
    
    func initSeg() -> UIView{
        let titles = ["相册","课程"]
        let unit:CGFloat = 75
        let seg = HMSegmentedControl(sectionTitles: titles)
        let width : CGFloat = unit * CGFloat(titles.count)
        let startx = CGRectGetWidth(self.view.frame)/2 - width/2
        seg.frame = CGRectMake(startx, 0, width, 39.5);
        seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        seg.selectionIndicatorColor = O2Color.MainColor
        seg.selectionIndicatorHeight = 2
        
        seg.titleTextAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(18),
            NSForegroundColorAttributeName: O2Color.TextGrey]
        seg.selectedTitleTextAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(18),
            NSForegroundColorAttributeName: O2Color.TextBlack
        ]
    
        seg.backgroundColor = UIColor.whiteColor()
        seg.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        let ret = UIView(frame: CGRectMake(0,0,width,39.5))
        ret.addSubview(seg)
        //ret.bottomBorderWidth = 0.4
        
        ret.backgroundColor = UIColor.whiteColor()
        
        let split = UIView(frame: CGRectMake(0,39,self.view.frame.width,1))
        split.backgroundColor = O2Color.BorderGrey
        ret.addSubview(split)
        
        
    
        seg.indexChangeBlock = {
            index in
            self.switchView(index)
        }

        
        return ret

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0)
        ]
        
       
        O2Nav.setController(self)
        
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
             self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            
            self.navigationController?.navigationBar.translucent = true
            self.navigationController?.navigationBar.backgroundColor = O2Color.MainColor.colorWithAlphaComponent(0)
            self.navigationController?.navigationBar.barTintColor = O2Color.MainColor.colorWithAlphaComponent(0)
            O2Nav.setNavigationBarTransformProgress(1)

            }, completion: nil)
        
        usr.loadRemote({ (tar) -> Void in
            let tarusr = tar as! User
            self.header.setContent(tarusr)
            self.title = tarusr.displayname
            
            
            //self.mypost.setUser(self.usrname)
            self.album.setUser(self.usrname)
            //self.mycourse.setUser(self.usrname)
            
            let gr = UITapGestureRecognizer()
            gr.addTarget(self, action: "showGym:")
            self.header.Location.addGestureRecognizer(gr)
            
            }, onfail: nil)
        
        var favimgname = "fav_bar"
        
        if Local.HASLOGIN {
            if let _ = Local.USER.upped_person.indexOf(self.usrname){
                self.faved = true
                favimgname = "fav_bar_active"
            }
        }
        self.favbtn = Helper.createButtonFromImg(favimgname, selector: "favperson", tar: self)
        
        
//        self.navigationItem.rightBarButtonItems = [
//            //            Helper.createBarButtonItemFromImg("fwd_bar", selector: "recommendperson", tar: self),
//            UIBarButtonItem(customView: self.favbtn)
//        ]
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        O2Nav.setNavTitle()
    }
    
    override func RYscrollViewDidScroll(scrollView: UIScrollView) {
        super.RYscrollViewDidScroll(scrollView)
        let current = self.containerScroll.contentOffset.y
        let percentage:CGFloat = current/(self.headerHeight - self.navHeaderHeight)
         O2Nav.setNavigationBarTransformProgress(1-percentage)
    }
    
    func favperson(){
        self.faved = !self.faved
        if self.faved{
            self.favbtn.setImage(NewUserDetailViewController.imgfav_active, forState: UIControlState.Normal)
            Local.USER.up(self.usrname)
        }
        else{
            self.favbtn.setImage(NewUserDetailViewController.imgfav, forState: UIControlState.Normal)
            Local.USER.up(self.usrname, direction: false)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func popTipViewWasDismissedByUser(popTipView: CMPopTipView!) {
        print("xxx")
    }


}
