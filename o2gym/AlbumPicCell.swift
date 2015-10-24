//
//  AlbumCell.swift
//  o2gym
//
//  Created by xudongbo on 7/29/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class AlbumPicCell: UICollectionViewCell {

    @IBOutlet weak var DelBtn: UIButton!
    @IBOutlet weak var Del: UIView!
    @IBOutlet weak var DelImg: UIImageView!
    @IBOutlet weak var Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.Del.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.8)
        self.DelImg.image = UIImage(named: "del")?.add_tintedImageWithColor(UIColor.whiteColor(), style: ADDImageTintStyleKeepingAlpha)
        // Initialization code
    }
    @IBAction func delCallback(sender: AnyObject) {
        //show dialog
        let alert = SIAlertView(title: "确认删除", andMessage: "确定删除吗？删除后图片将不能恢复")
        alert.addButtonWithTitle("删除", type: SIAlertViewButtonType.Default, handler: { (_) -> Void in
            alert.dismissAnimated(true)
        })
        alert.addButtonWithTitle("取消", type: .Cancel) { (_) -> Void in
            alert.dismissAnimated(true)
        }
        alert.show()
    }

}
