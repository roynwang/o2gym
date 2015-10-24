//
//  UserInputModalTextViewCell.swift
//  o2gym
//
//  Created by xudongbo on 10/13/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class UserInputModalTextViewCell: UITableViewCell, UITextFieldDelegate {
    @IBAction func touchOutside(sender: AnyObject) {
        self.InputText.resignFirstResponder()
    }

    @IBOutlet var InputText: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.InputText.delegate = self
        self.InputText.becomeFirstResponder()
//        self.contentView.topBorderWidth = 1
//        self.contentView.bottomBorderWidth = 1
//        self.contentView.borderColor = O2Color.BorderGrey

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
