//
//  CourseReviewController.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class CourseReviewController: UIViewController {

    var book:Book!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var Comments: UITextView!
    @IBOutlet weak var RateView: HCSStarRatingView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.title = "课程反馈"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.RateView.accurateHalfStars = true
        self.RateView.tintColor = O2Color.FavRed
        //self.RateView.addTarget(self, action: "rated:", forControlEvents: UIControlEvents.TouchUpInside)//        self.SubmitBtn.backgroundColor = O2Color.BorderGrey
        self.SubmitBtn.userInteractionEnabled = false
        
        // Dispose of any resources that can be recreated.
    }
    
    

    
    @IBAction func submitReview(sender: AnyObject) {
        print(self.Comments.text)
        self.book.comment = ""
        self.book.comment = self.Comments.text!
        self.book.rate = Int(self.RateView.value * 10)
        self.book.review()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    @IBAction func rated(sender:HCSStarRatingView){
        self.SubmitBtn.backgroundColor = O2Color.LightMainColor
        self.SubmitBtn.userInteractionEnabled = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
