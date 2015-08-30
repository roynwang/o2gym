//
//  BookedCourseCell.swift
//  o2gym
//
//  Created by xudongbo on 8/28/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class BookedCourseCell: UITableViewCell {

    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    @IBOutlet weak var StatusImg: UIImageView!
    @IBOutlet weak var Hour: UILabel!
    @IBOutlet weak var Day: UILabel!
    @IBOutlet weak var Avatar: UIImageView!
   
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
    
    func done(){
        self.Indicator.stopAnimating()
        self.Indicator.hidden = true
        self.StatusImg.hidden = false
        
    }
    func setByBook(book:Book?){
        self.book = book
        self.Avatar.fitLoad(self.book.coach.avatar!, placeholder: UIImage(named: "avatar"))
        self.Hour.text = Local.TimeMap[self.book.hour]
        self.Day.text = self.book.date
    }
    
}
