//
//  CoachDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVFoundation


class CoachDetailViewController: UIViewController, UIScrollViewDelegate{
    @IBOutlet weak var scrollview: UIScrollView!
    
    var limPicker:LimCameraImagePicker?
    var coach:User? = nil
    
    var isAlbumLoaded:Bool = false

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var avatar: UIImageView!
    
 
    
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet weak var history: UIButton!
    
    @IBOutlet weak var album: UIButton!
    
    @IBOutlet weak var showpicker: UIButton!
    
    
    @IBOutlet weak var historycontainer: UIView!
    var historycontroller:MyPostViewController!
    
    @IBOutlet weak var albumcontainer: UIView!
    var albumcontroller:AlbumViewController!
    
    @IBAction func taphistory(sender: AnyObject) {
        self.historycontainer.hidden = false
        self.albumcontainer.hidden = true
        self.resizeScrollView()
    }
    
    @IBAction func tapalbum(sender: AnyObject) {
        self.historycontainer.hidden = true
        self.albumcontainer.hidden = false
        
        if !self.isAlbumLoaded {
            self.albumcontroller.load(self.resizeScrollView)
            self.isAlbumLoaded = true
        }
        else{
            self.resizeScrollView()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.coach!.name
        self.albumcontainer.hidden = true
        self.avatar.load(self.coach!.avatar!, placeholder: nil, completionHandler: {
            ( _, uiimag,_) in
            self.avatar.image = Helper.RBSquareImage(uiimag!)
            })
        
        self.historycontroller = self.childViewControllers.first as! MyPostViewController
        
        self.albumcontroller = self.childViewControllers.last as! AlbumViewController
        
        self.scrollview.contentSize.height = 1000
        self.scrollview.delegate = self
        
        self.historycontroller.load(self.resizeScrollView)

        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(scroll: UIScrollView) {
        let currentOffset = scroll.contentOffset.y;
        let maximumOffset = scroll.contentSize.height - scroll.frame.size.height;
        
        // Change 10.0 to adjust the distance from bottom
        if (maximumOffset - currentOffset <= -40.0) {
           
        }
    }
    
    func resizeScrollView(){
        if self.albumcontainer.hidden {
            self.heightconstraint.constant = self.historycontroller.tableView.contentSize.height
            self.scrollview.contentSize.height = 200 + self.heightconstraint.constant
        }
        if self.historycontainer.hidden {
            let newheight:CGFloat = CGFloat(((self.albumcontroller.album.count)/4+1)*100)
            println("xxxxx")
            println(newheight)
            println("xxxxx")
            self.albumcontainer.frame = CGRect(
                x: self.albumcontainer.frame.origin.x,
                y: self.albumcontainer.frame.origin.y,
                width: self.albumcontainer.frame.width,
                height: self.heightconstraint.constant)
            self.scrollview.contentSize.height = 200 + self.heightconstraint.constant
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        self.resizeScrollView()
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
        if segue.identifier! == "mypost" {
            let vc = segue.destinationViewController as! MyPostViewController
            vc.usrname = self.coach?.name
        }
        if segue.identifier! == "album"{
            let vc = segue.destinationViewController as! AlbumViewController
            vc.usrname = self.coach?.name
            
        }

    }
    
    

}
