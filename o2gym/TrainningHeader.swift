//
//  TrainningHeader.swift
//  o2gym
//
//  Created by xudongbo on 10/23/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class TrainningHeader: UIView {
    
    
    var doAddRow:(()->Void)!
    var doRemoveSection:(()->Void)!
    
    @IBAction func removeRow(sender: AnyObject) {
        if self.doRemoveSection != nil {
            self.doRemoveSection()
        }
    }
    @IBAction func addRow(sender: AnyObject) {
        if self.doAddRow != nil {
            self.doAddRow!()
        }
    }

    
    @IBOutlet weak var DelBtn: UIButton!
    @IBOutlet weak var ActionName: UILabel!
    @IBOutlet weak var AddBtn: UIButton!
    
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
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TrainningHeader", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
