//
//  ProfileViewController.swift
//  o2gym
//
//  Created by xudongbo on 8/31/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerNib(UINib(nibName: "ProfileAvatarCell", bundle: nil), forCellReuseIdentifier: "profileavatarcell")
        self.tableView.registerNib(UINib(nibName: "PlainTextCell", bundle: nil), forCellReuseIdentifier: "plaintextcell")
        
        self.tableView.scrollEnabled = false
        self.tableView.bounces = false
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        
        //self.tableView.rowHeight = 100
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if Local.USER.iscoach {
            return 3
        }
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        }
        if section == 1 {
            return Local.USER.iscoach ? 4 : 1
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let celltype = getCellType(indexPath)
        switch celltype {
        case "profileavatarcell":
            return 100
        default:
            return 50
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let celltype = getCellType(indexPath)
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(celltype, forIndexPath: indexPath) as! ProfileAvatarCell
            cell.Avatar.fitLoad(Local.USER.avatar!, placeholder: UIImage(named: "avatar"))
            cell.Name.text = Local.USER.displayname
            cell.tappedAvatar = {
                (view) in
                let picker = FSMediaPicker()
                picker.delegate = self
                picker.showFromView(self.tableView)

            }
            return cell
        }
        
        let cell:PlainTextCell = tableView.dequeueReusableCellWithIdentifier("plaintextcell", forIndexPath: indexPath) as! PlainTextCell
        switch celltype {
        case "gym":
            cell.PlainText.text = "我的订单"
            return cell
        case "restday":
            cell.PlainText.text = "工作日设置"
            return cell
        case "workinghour":
            cell.PlainText.text = "工作时间设置"
            return cell
        case "myproduct":
            cell.PlainText.text = "课程设置"
            return cell
        default:
            return cell
        }
    }
    
    func getCellType(indexPath:NSIndexPath)->String{
        if indexPath.section == 0 && indexPath.row == 0 {
            return "profileavatarcell"
        }
        if indexPath.section == 1 {
            switch indexPath.row{
            case 0:
                return "gym"
            case 1:
                return "restday"
            case 2:
                return "workinghour"
            case 3:
                return "myproduct"
            default:
                return "error"
            }
        }
        return "error"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.borderColor = O2Color.BorderGrey
        
        if section == 0 {
            header.contentView.bottomBorderWidth = 0.5
            
        }
        if section == 1 {
            header.contentView.topBorderWidth = 0.5
            header.contentView.bottomBorderWidth = 0.5
        }
        if section == 2 {
            header.contentView.topBorderWidth = 0.5
            
        }
        if section == 3 {
            header.contentView.topBorderWidth = 0.5
            
        }
        header.contentView.backgroundColor = self.view.backgroundColor
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.section == 0 && indexPath.row == 0 {
            O2Nav.showUser(Local.USER.name!)
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            let cont =  sb.instantiateViewControllerWithIdentifier("orderlist") as! OrderedListViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 1 && Local.USER.iscoach {
            let cont =  sb.instantiateViewControllerWithIdentifier("workingtimeconfig") as! WorkingTimeConfigViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 2 && Local.USER.iscoach {
            
            let cont =  sb.instantiateViewControllerWithIdentifier("workinghourconfig") as! WorkingHourConfigViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 3 && Local.USER.iscoach {
            
            let cont =  sb.instantiateViewControllerWithIdentifier("myproduct") as! MyProductViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        
    }

    
}

extension ProfileViewController : FSMediaPickerDelegate {
    
    func mediaPicker(mediaPicker: FSMediaPicker!, didFinishWithMediaInfo mediaInfo: [NSObject : AnyObject]!) {
        let image : UIImage = mediaInfo["UIImagePickerControllerEditedImage"] as! UIImage
        var ratio:CGFloat = 1
        let imgdata = UIImageJPEGRepresentation(image, 1)!
        if imgdata.length/1024 > 50 {
            ratio = CGFloat(300)/CGFloat(imgdata.length/1024)
        }
        Local.USER.avatar = "test"
        //let nsdata = NSData(
        Helper.upload(UIImageJPEGRepresentation(image,ratio)!, complete: { (info, filename, resp) -> Void in
            Local.USER.avatar = Host.ImgHost + filename
            Local.USER.update(nil, onfail: nil)
            
            //update local
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ProfileAvatarCell
            cell.Avatar.fitLoad(Local.USER.avatar!, placeholder: nil)
        })

    }
    
}
