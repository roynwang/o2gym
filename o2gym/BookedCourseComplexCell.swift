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
    
    @IBAction func reviewTapped(sender: AnyObject) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("coursereview") as! CourseReviewController
        cont.book = self.book
        cont.hidesBottomBarWhenPushed = true
        O2Nav.pushViewController(cont)

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
        
        self.determineBtn(book!)
    }
    
    func determineBtn(book:Book){
        let currentDateTime = NSDate()
        let timestr = book.date + " " + Local.TimeMap[book.hour]
        let dateobj = NSDate.dateFromString(timestr, formatStr: "yyyy/MM/dd HH:mm")
        if dateobj.isLessThanDate(currentDateTime){
            self.ModifyTime.hidden = true
        } else {
            self.ModifyTime.hidden = false
        }
        if Local.USER.iscoach {
            self.Review.hidden = true
        } else {
            self.Review.hidden = false
        }
    }
    
    
}
