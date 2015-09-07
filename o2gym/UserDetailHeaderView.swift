//
//  UserDetailHeader.swift
//  o2gym
//
//  Created by xudongbo on 7/29/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class UserDetailHeaderView:UIView{

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
        self.Avator.layer.cornerRadius = self.Avator.frame.width/2
        self.Avator.layer.masksToBounds = true
        self.Avator.fitLoad(usr.avatar!, placeholder: UIImage(named:"avatar"))
        self.Name.text = usr.displayname
        if usr.gym != nil {
            self.Location.text = usr.gym
            self.Location.tag = usr.gym_id
            self.LocIcon.hidden = false
            
//        
//            let gr = UITapGestureRecognizer()
//            gr.addTarget(self, action: "showGym:")
//            self.Location.addGestureRecognizer(gr)
        }
            
    }
    


}