//
//  CoachDetailViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

protocol ContainerViewControllerDelegate {
    func update()

}

class CoachDetailViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollview: UIScrollView!
    

    var coach:User? = nil

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var avatar: UIImageView!
    
    var historyview:MyPostViewController!
    var albumview:UIViewController!
    
    var curview:String!
    
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet weak var history: UIButton!
    
    @IBOutlet weak var album: UIButton!
    
    @IBAction func taphistory(sender: AnyObject) {
        if self.curview == "history" {
            return
        }
        albumview.switchTo(historyview, parentController: self, direction: ">")
        self.curview = "history"
    }
    
    @IBAction func tapalbum(sender: AnyObject) {
        if self.curview == "album" {
            return
        }
        historyview.switchTo(albumview, parentController: self, direction: "<")
        self.curview = "album"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.curview = "history"
        self.title = self.coach!.name
        self.avatar.load(self.coach!.avatar!, placeholder: nil, completionHandler: {
            ( _, uiimag,_) in
            self.avatar.image = Helper.RBSquareImage(uiimag!)
            })
            
        historyview = self.childViewControllers[0] as! MyPostViewController
        albumview = self.storyboard?.instantiateViewControllerWithIdentifier("album") as! AlbumViewController
        
        self.scrollview.contentSize.height = 1000
        self.scrollview.delegate = self
        historyview.load(resizeScrollView)

        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(scroll: UIScrollView) {
        let currentOffset = scroll.contentOffset.y;
        let maximumOffset = scroll.contentSize.height - scroll.frame.size.height;
        
        // Change 10.0 to adjust the distance from bottom
        if (maximumOffset - currentOffset <= -40.0) {
            self.historyview.loadHistory(resizeScrollView)
        }
    }
    
    func resizeScrollView(){
        if self.curview == "history" {
            self.heightconstraint.constant = self.historyview.tableView.contentSize.height
            self.scrollview.contentSize.height = 200 + self.heightconstraint.constant
        }
        if self.curview == "album" {
            self.heightconstraint.constant = self.historyview.tableView.contentSize.height
            self.scrollview.contentSize.height = 200 + self.heightconstraint.constant
            
        }

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
//        if segue.identifier! == "album"{
//            let vc = segue.destinationViewController as! AlbumViewController
//            vc.usrname = self.coach?.name
//            
//        }

    }
    

}
