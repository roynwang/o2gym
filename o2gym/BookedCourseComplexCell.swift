//
//  BookedCourseComplexCell.swift
//  o2gym
//
//  Created by xudongbo on 8/30/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class BookedCourseComplexCell: UITableViewCell {

    @IBOutlet weak var AvatarCoach: UIImageView!
    @IBOutlet weak var Hour: UILabel!
    @IBOutlet weak var Day: UILabel!
    @IBOutlet weak var AvatarCustomer: UIImageView!
    
    @IBOutlet weak var Review: UIButton!
    @IBOutlet weak var ModifyTime: UIButton!
    var book:Book!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showCoach(){
        O2Nav.showUser(self.book.coach.name!)
    }
    func showCustomer(){
        O2Nav.showUser(self.book.customer.name!)
    }

    func setByBook(book:Book?){
        self.book = book
        self.AvatarCoach.fitLoad(self.book.coach.avatar!, placeholder: UIImage(named: "avatar"))
        self.AvatarCustomer.fitLoad(self.book.customer.avatar!, placeholder: UIImage(named: "avatar"))
        self.Hour.text = Local.TimeMap[self.book.hour]
        self.Day.text = self.book.coach.gym
        
        self.AvatarCoach.userInteractionEnabled = true
        self.AvatarCustomer.userInteractionEnabled = true
        
        let coachgr = UITapGestureRecognizer()
        coachgr.addTarget(self, action: "showCoach")
        let customergr = UITapGestureRecognizer()
        customergr.addTarget(self, action: "showCustomer")
        
        self.AvatarCoach.addGestureRecognizer(coachgr)
        self.AvatarCustomer.addGestureRecognizer(customergr)
        

    }
    
    
}
