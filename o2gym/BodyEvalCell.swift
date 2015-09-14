//
//  BodyEvalCell.swift
//  o2gym
//
//  Created by xudongbo on 9/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class BodyEvalTextField: HoshiTextField {
    var updatePlaceHolder: (()->Void)!
    override func textFieldDidEndEditing() {
        super.textFieldDidEndEditing()
        if updatePlaceHolder != nil {
            self.updatePlaceHolder!()
        }
    }
}

class BodyEvalCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var EvalItem: BodyEvalTextField!
    
    var evalData : BodyEvalItem!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.EvalItem.updatePlaceHolder = {
            self.evalData.value = self.EvalItem.text
            //self.updateValue()
        }
        // Initialization code
        //self.EvalItem.delegate = self
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(data:BodyEvalItem){
        self.evalData = data
        if data.value != nil {
            self.EvalItem.text = data.value
        }
        self.updateValue()
    
    }
    func updateValue(){
           self.EvalItem.placeholder = "\(self.evalData.option) (\(self.evalData.unit))"
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.evalData.value = textField.text
        self.updateValue()
    }

}
