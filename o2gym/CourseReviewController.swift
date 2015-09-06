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
    @IBOutlet weak var RateView: HCSStarRatingView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.RateView.accurateHalfStars = true
        self.RateView.tintColor = O2Color.FavRed
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var Comments: UITextView!

    
    @IBAction func submitReview(sender: AnyObject) {
        println(self.Comments.text)
        self.book.comment = ""
        self.book.comment = self.Comments.text!
        self.book.rate = Int(self.RateView.value * 10)
        self.book.review()
        self.navigationController?.popViewControllerAnimated(true)
        
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
