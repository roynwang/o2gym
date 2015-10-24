//
//  UserDetailHeader.swift
//  o2gym
//
//  Created by xudongbo on 7/29/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class UserDetailHeaderView:UIView{

    @IBOutlet weak var HeaderBg: UIImageView!
    var usr:User!
    @IBOutlet weak var Sex: UIImageView!
    @IBOutlet weak var Rate: HCSStarRatingView!
    @IBOutlet weak var CourseCount: UILabel!
    @IBOutlet weak var OrderCount: UILabel!
    @IBOutlet weak var LocIcon: UIImageView!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Avator: UIImageView!
    public func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "UserDetailHeaderView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file

        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.backgroundColor = O2Color.MainColor
        
        //view.backgroundColor = O2Color.BgGreyColor
        //self.Avator.layer.cornerRadius = self.Avator.frame.width/2
        return view
    }
    public func setContent(usr:User){
        self.usr = usr
        self.Avator.layer.cornerRadius = self.Avator.frame.width/2
        self.Avator.layer.masksToBounds = true
        self.Avator.fitLoad(usr.avatar!, placeholder: UIImage(named:"avatar"))
        self.Name.text = usr.displayname
        if usr.gym_id != nil {
            self.Location.text = usr.gym
            self.Location.tag = usr.gym_id
            self.LocIcon.hidden = false
        }
        self.OrderCount.text = usr.order_count.toString()
        self.CourseCount.text = usr.course_count.toString()
        self.Rate.value = CGFloat(usr.rate)/(CGFloat(usr.course_count)*10)
        print(self.Rate.value)
        self.Rate.frame = self.Rate.frame
        if usr.sex == true{
            self.Sex.image = UIImage(named: "male")
        } else {
            self.Sex.image = UIImage(named: "female")
        }
        self.HeaderBg.image = UIImage(named: "headerbg")!
        //self.Rate.set
    }
    @IBAction func showPic(sender: AnyObject) {
        let browser = SDPhotoBrowser()
        browser.sourceImagesContainerView = self.Avator
        browser.imageCount = 1
        browser.delegate = self
        browser.currentImageIndex = 0
        browser.show()

    }
}

extension UserDetailHeaderView : SDPhotoBrowserDelegate{
    public func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        return NSURL(string:self.usr.avatar!)
    }
    public func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return self.Avator.image!
    }
}
