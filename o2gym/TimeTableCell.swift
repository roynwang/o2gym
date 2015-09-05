//
//  TimeTableCell.swift
//  o2gym
//
//  Created by xudongbo on 8/28/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class TimeTableCell: UICollectionViewCell {

    var tappedcb : ((Int)->Void)?
    var isActive : Bool = false
    
    @IBOutlet weak var Time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.customLabel(self.Time)
    }
    
    
    func tapped(gr:UITapGestureRecognizer){
        let label = gr.view! as! UILabel
        if self.tappedcb != nil {
            self.tappedcb!(label.tag)
        }
    }
    
    func customLabel(label:UILabel){
        label.layer.masksToBounds = true
        label.layer.borderColor = O2Color.MainColor.CGColor
        label.textColor = O2Color.MainColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 3
        label.backgroundColor = UIColor.clearColor()
        label.userInteractionEnabled = true
        
        let gr:UITapGestureRecognizer = UITapGestureRecognizer()
        gr.addTarget(self, action: "tapped:")
        label.addGestureRecognizer(gr)
    }
    
    
    func enableLabel() {
        Time.layer.borderColor = O2Color.LightMainColor.CGColor
        Time.textColor = O2Color.LightMainColor
        Time.backgroundColor = UIColor.clearColor()
        Time.userInteractionEnabled = true
    }
    
    func disableLabel() {
        Time.layer.borderColor = O2Color.BorderGrey.CGColor
        Time.backgroundColor = UIColor.clearColor()
        Time.textColor = O2Color.BorderGrey
        Time.userInteractionEnabled = false
    }
    func activeLabel(){
        Time.layer.borderColor = O2Color.LightMainColor.CGColor
        Time.backgroundColor = O2Color.LightMainColor
        Time.textColor = UIColor.whiteColor()
        self.isActive = true
    }
    
    func deactiveLabel(){
        Time.layer.borderColor = O2Color.LightMainColor.CGColor
        Time.backgroundColor = UIColor.clearColor()
        Time.textColor = O2Color.LightMainColor
        self.isActive = false
    }
    
    func toggle()->Bool{
        if Time.backgroundColor == O2Color.LightMainColor {
            self.deactiveLabel()
            return false
        } else {
            self.activeLabel()
            return true
        }
    }
}
