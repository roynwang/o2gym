//
//  NearByGymCell.swift
//  o2gym
//
//  Created by xudongbo on 9/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class NearByGymCell: UITableViewCell {

    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var Loc: UILabel!
    @IBOutlet weak var GymName: UILabel!

    @IBOutlet weak var BgImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = O2Color.BgGreyColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setGym(gym:Gym){
        self.BgImage.loadUrl(gym.img_set[0],placeholder: nil) { (_) -> () in
            UIImageView.addShadowWithColor(UIColor.lightGrayColor(), inImageView: self.BgImage)
        }
        //self.Coach.fitLoad(gym.coaches[0].avatar!)
        let width:CGFloat = 26
        let containerstartx:CGFloat = 10
        let starty:CGFloat = 105
        //let starty = self.GymName.frame.origin.y
        let coachContainer = UIView(frame: CGRectMake(containerstartx, starty, 105, width + 6))
        
        var startx:CGFloat = 7
        for coach in gym.coaches{
            let coachimg = UIImageView(frame: CGRectMake(startx, 3, width, width))
            print(coach.avatar!)
            coachimg.fitLoad(coach.avatar!)
            startx += width
            startx += 5
            coachContainer.addSubview(coachimg)
            coachimg.borderColor = O2Color.BorderGrey
            coachimg.borderWidth = 1.5
            coachimg.cornerRadius = width/2
        }
        coachContainer.frame = CGRectMake(containerstartx, starty, startx + 2, width+6)
        coachContainer.backgroundColor = UIColor(rgba: "#444")
        coachContainer.cornerRadius = (width + 10)/2
        
        self.contentView.addSubview(coachContainer)
        self.GymName.text = gym.name
        self.Distance.text = gym.distance.toString() + " 米"
        self.Loc.text = gym.address
    }
    
}
