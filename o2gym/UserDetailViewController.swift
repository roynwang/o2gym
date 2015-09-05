//
//  UserDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/28/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

private var CusomHeaderInsetObserver = 123

public class UserDetailViewController: ARSegmentPageController {
    
    
    static var instance:UserDetailViewController!
    
    
    var bgImage:UIImage!
    var blurImg:UIImage!
    var usrname:String = ""
    var usr : User!
    var mypost:MyPostViewController!
    var album:AlbumViewController!
    var mycourse:MyCourseViewController!
    var favbtn:UIButton!
    
    static let imgfav = UIImage(named:"fav_bar")
    static let imgfav_active = UIImage(named: "fav_bar_active")
    var faved:Bool = false
    
    @IBOutlet weak var BottomBar: UIView!
    
    var barvisible:Bool = false
    
    
    public override func customHeaderView()->UIView {
        let header = UserDetailHeaderView()
        return header.loadViewFromNib()
    }
    public override func customSegmentView()->HMSegmentedControl? {
        let titles = ["相册","氧气罐","课程"]
        let unit:CGFloat = 75
        let seg = HMSegmentedControl(sectionTitles: titles)
        let width : CGFloat = unit * CGFloat(titles.count)
        let startx = CGRectGetWidth(self.view.frame)/2 - width/2
        seg.frame = CGRectMake(startx, 0, width, 39.5);
        seg.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        seg.selectionIndicatorColor = O2Color.MainColor
        seg.selectionIndicatorHeight = 1
        
        seg.titleTextAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName: O2Color.TextGrey]
        seg.selectedTitleTextAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName: O2Color.TextBlack
        ]
        
        
        seg.backgroundColor = UIColor.whiteColor()
        seg.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        return seg
        
    }
    public override func viewDidLoad() {
        self.headerHeight = 205
        self.segmentHeight = 40
        self.title = self.usrname
        self.BottomBar.backgroundColor = O2Color.UpdateToast.colorWithAlphaComponent(0.9)
        self.backgroundColor = O2Color.BgGreyColor
        self.navigationController?.navigationBar.translucent = true
        mypost = MyPostViewController(nibName: "MyPostViewController", bundle: nil, usrname:self.usrname)
        album = AlbumViewController(nibName: "AlbumViewController", bundle: nil, usrname:self.usrname)
        
        mycourse = MyCourseViewController(nibName: "MyPostViewController", bundle: nil, usrname:self.usrname)
        //mypost.setUser("royn")
        
        self.setViewControllers([album, mypost,mycourse])
        super.viewDidLoad()
        
        self.segmentMiniTopInset = 20 + CGFloat(self.navigationController!.navigationBar.frame.height)
        
        
        
        
        
        let header = self.headerView as! UserDetailHeaderView
        self.usr = User(name: self.usrname)
        
        
        self.navigationItem.leftBarButtonItems = [Helper.createBarButtonItemFromImg("back", selector: "back", tar: self)]
        
        //usr.loadRemote(header.setContent, onfail: nil)
        usr.loadRemote({ (tar) -> Void in
            let tarusr = tar as! User
            header.setContent(tarusr)
            if tarusr.iscoach && tarusr.name != Local.USER.name{
                self.BottomBar.hidden = false
            }
            self.title = tarusr.displayname
        }, onfail: nil)
        
        var favimgname = "fav_bar"
        
        if let index = find(Local.USER.upped_person, self.usrname){
            self.faved = true
            favimgname = "fav_bar_active"
        }
        self.favbtn = Helper.createButtonFromImg(favimgname, selector: "favperson", tar: self)
        
        self.navigationItem.rightBarButtonItems = [
            Helper.createBarButtonItemFromImg("fwd_bar", selector: "recommendperson", tar: self),
            UIBarButtonItem(customView: self.favbtn)
        ]
        
        
        //        self.addObserver(self,forKeyPath:"segmentToInset",options:NSKeyValueChangeNewKey,context:CusomHeaderInsetObserver)
        
        //        self.addObserver(self, forKeyPath: "segmentToInset", options: [NSKeyValueChangeNewKey], context: CusomHeaderInsetObserver)
        
        self.addObserver(self,
            forKeyPath: "segmentToInset",
            options: .New,
            context: &CusomHeaderInsetObserver)
    }
    
    func recommendperson(){
        let wb = Weibo(usr: Local.USER)
        wb.recommendUser(self.usr, onsuccess: nil, onfail: nil)
    }
    
    public override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0)
        ]
        
        mypost.setUser(usrname)
        album.setUser(usrname)
        mycourse.setUser(usrname)
        O2Nav.setController(self)
        
        
        var image = UIImage(named: "back")
        
        let b1 = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "leftNavButtonClick")
        //toolbar.setItems([b1], animated: false)
        self.navigationController?.setToolbarItems([b1], animated: true)
        
        UIView.animateWithDuration(0.5, animations: {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            }, completion: {(_) in
                
        })
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backgroundColor = O2Color.MainColor.colorWithAlphaComponent(0)
        self.navigationController?.navigationBar.barTintColor = O2Color.MainColor.colorWithAlphaComponent(0)
        O2Nav.setNavigationBarTransformProgress(1)
        
    }
    
    func back()
    {
        O2Nav.setNavigationBarTransformProgress(0)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func favperson(){
        self.faved = !self.faved
        if self.faved{
            self.favbtn.setImage(UserDetailViewController.imgfav_active, forState: UIControlState.Normal)
            Local.USER.up(self.usrname)
        }
        else{
            self.favbtn.setImage(UserDetailViewController.imgfav, forState: UIControlState.Normal)
            Local.USER.up(self.usrname, direction: false)
        }
    }
    
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public override func viewDidAppear(animated: Bool) {
        //           self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    }
    
    public override func viewDidDisappear(animated: Bool) {
       O2Nav.resetNav()
    }
    
    
    public override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent;
    }
    
    public override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        
        if context == &CusomHeaderInsetObserver {
            let transstart = 0
            let transend:CGFloat = self.headerHeight - self.segmentMiniTopInset
            let topinset = change[NSKeyValueChangeNewKey] as! Float
            println(topinset)
            if CGFloat(topinset) > self.segmentMiniTopInset {
                let percentage =  (self.headerHeight - CGFloat(topinset))/transend
                O2Nav.setNavigationBarTransformProgress(1-percentage)
            }else{
                O2Nav.setNavigationBarTransformProgress(0)
            }
        }
        
    }
    
    
    
    //    public override  func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
    //        let topInset = change[NSKeyValueChangeNewKey]?.floatValue
    //        if topInset <= Float(self.segmentMiniTopInset) {
    //            self.title = "ARSegmentPager";
    //            //self.headerView.imageView.image = self.blurImage;
    //        }else{
    //            self.title = nil;
    //            //self.pager.headerView.imageView.image = self.defaultImage;
    //        }
    //
    //    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    deinit {
        self.removeObserver(self, forKeyPath: "segmentToInset")
    }
    
    @IBAction func book(sender: AnyObject) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("book") as! BookViewController
        cont.coach = self.usr
        //cont.usrname = usrname
        cont.hidesBottomBarWhenPushed = true
        O2Nav.pushViewController(cont)
        
    }
}
