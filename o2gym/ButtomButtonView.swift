//
//  ButtomButtonView.swift
//  o2gym
//
//  Created by xudongbo on 10/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class ButtomButtonView: UIView {

    @IBOutlet weak var VrWidth: NSLayoutConstraint!
    @IBOutlet weak var Vr: UIView!
    @IBOutlet weak var Right: UIButton!
    @IBOutlet weak var Left: UIButton!
    
    var view:UIView!
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        //super.init()
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]

        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
       VrWidth.constant = 0.5
       addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "BottomButtonView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }

}
