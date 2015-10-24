//
//  CustomerItemCell.swift
//  o2gym
//
//  Created by xudongbo on 10/12/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class CustomerItemCell: UITableViewCell {

    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Name: UILabel!
    var usr:User!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func AvatarTapped(sender: AnyObject) {
        //O2Nav.showUser(self.usr.name!)
    }
    
    func setContent(user:User){
        self.usr = user
        self.Avatar.fitLoad(user.avatar!, placeholder: UIImage(named: "avatar"))
        self.Name.text = user.displayname
    }
    
}
