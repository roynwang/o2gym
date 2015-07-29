//
//  UserDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/28/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

public class UserDetailViewController: ARSegmentPageController {
    
    
    static var instance:UserDetailViewController!

    var bgImage:UIImage!
    var blurImg:UIImage!
    var usrname:String = ""
    var mypost:MyPostViewController!
    var album:AlbumViewController!
    
    class func sharedInstance()->UserDetailViewController{
        UserDetailViewController.instance = (UserDetailViewController.instance ?? UserDetailViewController())
        return UserDetailViewController.instance
    }
    
    func setUser(usrname:String){
        self.usrname = usrname
        
        self.title = self.usrname
    }
    
    public override func viewDidAppear(animated: Bool) {
        mypost.setUser(usrname)
        album.setUser(usrname)
        O2Nav.sharedInstance()!.showDetail()
    }


    public override func viewDidLoad() {
        
        mypost = MyPostViewController(nibName: "MyPostViewController", bundle: nil, usrname:self.usrname)
        album = AlbumViewController(nibName: "AlbumViewController", bundle: nil, usrname:self.usrname)
        //mypost.setUser("royn")
        
        self.setViewControllers([album, mypost])
        super.viewDidLoad()
        
        self.addObserver(self, forKeyPath: "segmentToInset", options: NSKeyValueObservingOptions(), context: nil)
        
//        self.freezenHeaderWhenReachMaxHeaderHeight = true
//        self.segmentMiniTopInset = 40;
        
        
       
        //mypost.load(nil)
        //album.load(nil)
        //self.headerView.backgroundColor = O2Color.MainColor
        
   
        // Do any additional setup after loading the view.
    }


    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent;
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
