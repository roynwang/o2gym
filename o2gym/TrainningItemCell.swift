//
//  TrainningItemCell.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class TrainningItemCell: UITableViewCell {

    @IBOutlet weak var Repeatttimes: KaedeTextField!
    @IBOutlet weak var Weight: KaedeTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUnits(unitStr:String){
        let units = unitStr.componentsSeparatedByString("|")
        
        self.Weight.hidden = false
        self.Weight.text = ""
        self.Repeatttimes.hidden = false
        self.Repeatttimes.text = ""
        
        self.Weight.placeholder = units[0]
        if units.count > 1 {
            self.Repeatttimes.placeholder = units[1]
        }
        if  units[0] == "" {
            self.Weight.hidden = true
        }
        if units.count < 2 || units[1] == "" {
            self.Repeatttimes.hidden = true
        }

    }
    
    func setUnits(withaction action:WorkoutAction){
        self.setUnits(action.units)
    }
    func setEditable(editable:Bool){
        self.Repeatttimes.userInteractionEnabled = editable
    }
    
}
