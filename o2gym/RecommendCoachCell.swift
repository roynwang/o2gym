//
//  RecommendCoach.swift
//  o2gym
//
//  Created by xudongbo on 7/12/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RecommendCoachCell: UITableViewCell {

 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avator: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setContent(item:BaseDataItem){
        let usr:User = item as! User
        println(usr.name)
        self.name.text = usr.name!
        println(usr.avatar)
        if usr.avatar != nil{
            self.avator.load(usr.avatar!, placeholder: nil, completionHandler: {
                ( _, uiimag,_) in
                    self.avator.image = Helper.RBSquareImage(uiimag!)
                
            })
        }
        
    }
    
}
