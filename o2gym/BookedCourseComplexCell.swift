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
    
    @IBOutlet weak var Work: UIButton!
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
    @IBAction func workTapped(sender: AnyObject) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let cont =  sb.instantiateViewControllerWithIdentifier("train") as! TrainViewController
  
        let cont = NewTrainningController()
        cont.usrname = self.book.customer.name
        cont.book = self.book
        cont.isNew = true

        cont.hidesBottomBarWhenPushed = true
        O2Nav.pushViewController(cont)
        
    }
    
    @IBAction func postponeTapped(sender: AnyObject) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("book") as! BookViewController
        //create order from book
        let order = OrderItem(name: Local.USER.name!, orderid: book.orderId)
        order.loadRemote({ (_) -> Void in
            order.booked = [self.book]
            cont.order = order
            cont.isSingleBook = true
            cont.hidesBottomBarWhenPushed = true
            O2Nav.pushViewController(cont)
            }, onfail: nil)
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
    
    func showCustomerDetail(){
        O2Nav.showCustomerDetail(self.book.customer)
    }
    
    func setByBook(book:Book?){
        self.book = book
        self.AvatarCoach.fitLoad(self.book.coach.avatar!, placeholder: UIImage(named: "avatar"))
        self.AvatarCustomer.fitLoad(self.book.customer.avatar!, placeholder: UIImage(named: "avatar"))
        self.Hour.text = Local.TimeMap[self.book.hour]
        if Local.USER.iscoach {
            self.Day.text = self.book.customer.displayname
        } else {
            self.Day.text = self.book.coach.displayname
        }
        
        self.AvatarCoach.userInteractionEnabled = true
        self.AvatarCustomer.userInteractionEnabled = true
        
        let coachgr = UITapGestureRecognizer()
        coachgr.addTarget(self, action: "showCoach")
        let customergr = UITapGestureRecognizer()
        customergr.addTarget(self, action: "showCustomer")
        
        
        let customerdetailgr = UITapGestureRecognizer()
        customerdetailgr.addTarget(self, action: "showCustomerDetail")
        
        
        self.AvatarCoach.addGestureRecognizer(coachgr)
        self.AvatarCustomer.addGestureRecognizer(customergr)
        self.Day.addGestureRecognizer(customerdetailgr)
        
        self.determineBtn(book!)
    }
    
    func determineBtn(book:Book){
        let currentDateTime = NSDate()
        let timestr = book.date + " 00:00"
        let dateobj = NSDate.dateFromString(timestr, formatStr: "yyyy/MM/dd HH:mm")
        
        self.Review.hidden = true
        self.ModifyTime.hidden = true
        self.Work.hidden = true
        if book.done && book.rate != nil {
            return
        }
        
        //未上课的 可以改期
        if !book.done {
            self.ModifyTime.hidden = false
        }
        //当天的 + 教练 + 未完成 可以上课
        if Local.USER.iscoach &&
            dateobj.isLessThanDate(currentDateTime) &&
            !book.done {
                self.Work.hidden = false
        }
        // 已完成 ＋ 未评价 ＋ 用户 可以评价
        if !Local.USER.iscoach &&
            book.done &&
            book.rate == nil {
                self.Review.hidden = false
        }
        
        
        
        //if is coach
//        if Local.USER.iscoach {
//            if dateobj.isLessThanDate(currentDateTime) && !book.done {
//                self.Work.hidden = false
//            } else if dateobj.isGreaterThanDate(currentDateTime) {
//                self.ModifyTime.hidden = false
//            }
//        } else {
//            if book.rate == nil && book.done{
//                self.Review.hidden = false
//                
//            } else {
//            //if dateobj.isGreaterThanDate(currentDateTime) {
//                self.ModifyTime.hidden = false
//            //}
//            }
//        }
        
    }
    
    
}
