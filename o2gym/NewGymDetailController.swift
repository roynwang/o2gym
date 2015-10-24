//
//  NewUserDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/7/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class NewGymDetailViewController: RYProfileViewController {
    
    
    var gymid:Int!
    var gym:Gym!
    //var mypost:MyPostViewController!
    var coaches:CoachListController!
    var profile:GymDetailController!
    var mask:UIImageView!
    var btm:ButtomButtonView!
    
    var faved:Bool = false
    
    var header:ImagePlayerView!
    
    override func viewDidLoad() {
        
        
        self.coaches = CoachListController()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        self.profile =  sb.instantiateViewControllerWithIdentifier("gymdetail") as! GymDetailController
        
        self.viewControllerSet = [self.coaches,self.profile]
        self.header = ImagePlayerView(frame : CGRectMake(0,0, self.view.frame.width, self.headerHeight))
        self.headerView = self.header
        self.segmentControlView = self.initSeg()
        self.header.imagePlayerViewDelegate = self
        
        super.viewDidLoad()
        
        self.view.backgroundColor = O2Color.MainColor
        
      
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
 
    
    func initSeg() -> UIView{
        let titles = ["教练","介绍"]
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
            self.btm.hidden = (index != 1)
            self.switchView(index)
        }
        
        self.header.scrollInterval = 5
        self.header.pageControlPosition = .BottomCenter
        
        
        return ret
        
    }

    
    override func viewWillAppear(animated: Bool) {
        
        mask = UIImageView(image:UIImage.add_imageWithGradient([UIColor.darkGrayColor().colorWithAlphaComponent(0.95),UIColor.clearColor().colorWithAlphaComponent(0.1),UIColor.clearColor().colorWithAlphaComponent(0),UIColor.clearColor().colorWithAlphaComponent(0)], size: CGSizeMake(self.view.frame.width, 250), direction: ADDImageGradientDirectionVertical))
        self.navigationController?.view.insertSubview(mask, atIndex: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0)
        ]
        
        
        O2Nav.setController(self)
        
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            O2Nav.nav!.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            
            O2Nav.nav!.translucent = true
            O2Nav.nav!.backgroundColor = O2Color.MainColor.colorWithAlphaComponent(0)
            O2Nav.setNavigationBarTransformProgress(1)
            }, completion: nil)
        
        self.gym = Gym(id: self.gymid)
        self.gym.loadRemote({ (_) -> Void in
            self.header.reloadData()
            self.coaches.gym = self.gym
            self.profile.gym = self.gym
            
            O2Nav.setNavTitle(self.gym.name)
            self.coaches.tableView.reloadData()
            self.profile.tableView.reloadData()
            
            
            
            self.btm = ButtomButtonView(frame: CGRectMake(0, self.view.frame.height - 45, self.view.frame.width, 45))
            

            let hr = UIView(frame: CGRectMake(0, 0,self.view.frame.width, 0.5))
            hr.backgroundColor = O2Color.BorderThick
            self.btm.addSubview(hr)
            self.btm.backgroundColor = UIColor(rgba: "#f6f6f6")
            self.btm.bringSubviewToFront(hr)
            self.btm.hidden = true
            self.view.addSubview(self.btm)
            
            self.view.bringSubviewToFront(self.btm)
            
            self.btm.Right.addTarget(self, action: "showMapPic", forControlEvents: UIControlEvents.TouchUpInside)
       
            self.btm.Left.addTarget(self, action: "makeCall", forControlEvents: UIControlEvents.TouchUpInside)
            }, onfail: nil)
        


    }
    
    override func viewWillDisappear(animated: Bool) {
        O2Nav.setNavTitle()
        self.mask.removeFromSuperview()
    }
    
    override func RYscrollViewDidScroll(scrollView: UIScrollView) {
//        super.RYscrollViewDidScroll(scrollView)
//        let current = self.containerScroll.contentOffset.y
//        let percentage:CGFloat = current/(self.headerHeight - self.navHeaderHeight)
//        O2Nav.setNavigationBarTransformProgress(1-percentage)
    }
    
    
    func showMapPic(){
        let imgview = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.width))
        imgview.loadUrl(self.gym.mappic)
        self.presentSemiView(imgview)
    }
    func makeCall(){
        if let url = NSURL(string: "tel://\(self.gym.phone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}

extension NewGymDetailViewController : ImagePlayerViewDelegate {
    
    func numberOfItems()->NSInteger {
        return self.gym.img_set.count
    }
    func imagePlayerView(imagePlayerView: ImagePlayerView!, loadImageForImageView imageView: UIImageView!, index: Int) {
        let imgurl:String = self.gym.img_set[index]
        let iv = UIImageView(frame: CGRectMake(0, 0, self.header.frame.width, self.header.frame.height))
        iv.loadUrl(imgurl, placeholder: nil) { (_) -> Void in
            imageView.image = iv.image
        }
        
//        imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string:imgurl)!)!)
    }
    
}
