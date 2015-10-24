//
//  ProfileAvatarCell.swift
//  o2gym
//
//  Created by xudongbo on 8/31/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class ProfileAvatarCell: UITableViewCell {

    var usr:User!
    @IBOutlet weak var Name: UILabel!
    var tappedAvatar : ((UIView)->Void)!
    @IBAction func showAvatarPicker(sender: UIButton) {
        if self.tappedAvatar != nil{
            self.tappedAvatar!(self.Avatar)
        }
    }
    @IBOutlet weak var Avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }
    
    func setUser(user:User){
        self.usr = user
        self.Avatar.fitLoad(self.usr.avatar!,placeholder: UIImage(named: "avatar"))
        self.Name.text = self.usr.displayname
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func showPic(sender: AnyObject) {
        let browser = SDPhotoBrowser()
        browser.sourceImagesContainerView = self.Avatar
        browser.imageCount = 1
        browser.delegate = self
        browser.currentImageIndex = 0
        browser.show()
    }
    

}
extension ProfileAvatarCell : SDPhotoBrowserDelegate{
    func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        return NSURL(string:self.usr.avatar!)
    }
    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return self.Avatar.image!
    }
}


