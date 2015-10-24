//
//  UserCommentCell.swift
//  o2gym
//
//  Created by xudongbo on 10/7/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class UserCommentCell: UITableViewCell {


    @IBOutlet weak var CommentText: UILabel!
    @IBOutlet weak var Rate: HCSStarRatingView!
    @IBOutlet weak var Avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Rate.userInteractionEnabled = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setView(book:Book){
        print(CGFloat(book.rate)/10)
        self.Avatar.fitLoad(book.customer.avatar!, placeholder: UIImage(named: "avatar"))
        self.CommentText.text = book.comment
        self.Rate.value = CGFloat(book.rate)/10
    }
    

    
}
