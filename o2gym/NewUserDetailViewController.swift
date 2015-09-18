//
//  NewUserDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/7/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class NewUserDetailViewController: RYProfileViewController {
    var mypost:MyPostViewController!
    var album:AlbumViewController!
    var mycourse:MyGoodsViewController!
    var usrname:String = ""
    var usr : User!
    var favbtn:UIButton!
    static let imgfav = UIImage(named:"fav_bar")
    static let imgfav_active = UIImage(named: "fav_bar_active")
    var faved:Bool = false
    
    var header:UserDetailHeaderView!

    override func viewDidLoad() {
        
//        self.mypost = MyPostViewController(nibName: "MyPostViewController", bundle: nil, usrname:self.usrname)
//        self.mypost.rydelegate = self
        
        
        
        self.album = AlbumViewController(nibName: "AlbumViewController", bundle: nil, usrname:self.usrname)
        self.album.rydelegate = self
        
        self.mycourse = MyGoodsViewController(nibName: "MyPostViewController", bundle: nil, usrname:self.usrname)
        self.mycourse.rydelegate = self
        
        self.viewControllerSet = [album,mycourse]
        self.header = self.initHeaderView()
        self.headerView = self.header
        self.segmentControlView = self.initSeg()
    
        self.usr = User(name: self.usrname)
        
        super.viewDidLoad()
        
        self.view.backgroundColor = O2Color.MainColor
        
        // Do any additional setup after loading the view.
    }
    

    
    func recommendperson(){
        let wb = Weibo(usr: Local.USER)
        wb.recommendUser(self.usr, onsuccess: nil, onfail: nil)
    }
    
    func showGym(gr:UITapGestureRecognizer){
        print("show gym")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("gymdetail") as! GymDetailController
        //cont.product = self.productlist.datalist[indexPath.section] as! Product
        cont.gymid = gr.view!.tag
        O2Nav.pushViewController(cont)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
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
            if let index = Local.USER.upped_person.indexOf(self.usrname){
                self.faved = true
                favimgname = "fav_bar_active"
            }
        }
        self.favbtn = Helper.createButtonFromImg(favimgname, selector: "favperson", tar: self)
        
        
        self.navigationItem.rightBarButtonItems = [
//            Helper.createBarButtonItemFromImg("fwd_bar", selector: "recommendperson", tar: self),
            UIBarButtonItem(customView: self.favbtn)
        ]

    }
    
    func initHeaderView()->UserDetailHeaderView {
        let header = UserDetailHeaderView()
        let ret = header.loadViewFromNib() as! UserDetailHeaderView
        ret.frame = CGRectMake(0,0, self.view.frame.width, 200)
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
            NSFontAttributeName: UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName: O2Color.TextGrey]
        seg.selectedTitleTextAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(16),
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

}
