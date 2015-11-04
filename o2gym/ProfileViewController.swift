//
//  ProfileViewController.swift
//  o2gym
//
//  Created by xudongbo on 8/31/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.registerNib(UINib(nibName: "ProfileAvatarCell", bundle: nil), forCellReuseIdentifier: "profileavatarcell")
        self.tableView.registerNib(UINib(nibName: "BasicConfigCell", bundle: nil), forCellReuseIdentifier: "basicconfigcell")
        
        self.tableView.bounces = false
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.backgroundColor = O2Color.BgGreyColor
        
//        self.navigationController?.toolbarHidden = true
        
        
        
        //self.tableView.rowHeight = 100
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        if Local.USER.needRefresh {
            self.tableView.reloadData()
            Local.USER.needRefresh = false
        }
        if self.tableView.indexPathForSelectedRow != nil {
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: true)

        }
        O2Nav.setController(self)
        
        O2Nav.setNavigationBarTransformProgress(0)

    }
    override func viewDidAppear(animated: Bool) {
        O2Nav.setNavTitle("设置")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.

        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        }
        if section == 1 {
            return Local.USER.iscoach ? 7 : 3
        }
        if section == 2 {
            return 2
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
            cell.setUser(Local.USER)
//            cell.Avatar.fitLoad(Local.USER.avatar!, placeholder: UIImage(named: "avatar"))
//            cell.Name.text = Local.USER.displayname
            cell.tappedAvatar = {
                (view) in
                let picker = FSMediaPicker()
                picker.delegate = self
                picker.showFromView(self.tableView)

            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("basicconfigcell", forIndexPath: indexPath) as! BasicConfigCell
        switch celltype {
        case "album":
            cell.OptionKey.text = "相册"
        case "order":
            cell.OptionKey.text = "我的订单"
        case "profile":
            cell.OptionKey.text = "基本资料"
        case "restday":
            cell.OptionKey.text = "工作日设置"
        case "workinghour":
            cell.OptionKey.text = "工作时间设置"
        case "myproduct":
            cell.OptionKey.text = "课程设置"
        case "aboutme":
            cell.OptionKey.text = "关于我们"
        case "privacy":
            cell.OptionKey.text = "服务条款和隐私政策"
        case "income":
            cell.OptionKey.text = "收入统计"
        default:
            return cell
        }
         return cell
    }
    
    func getCellType(indexPath:NSIndexPath)->String{
        if indexPath.section == 0 && indexPath.row == 0 {
            return "profileavatarcell"
        }
        if indexPath.section == 1 {
            switch indexPath.row{
            case 0:
                return "profile"
            case 2:
                return "album"
            case 1:
                return "order"
            case 3:
                return "restday"
            case 4:
                return "workinghour"
            case 5:
                return "myproduct"
            case 6:
                return "income"
            default:
                return "error"
            }
        }
        if indexPath.section == 2 {
            switch indexPath.row{
            case 0:
                return "aboutme"
            case 1:
                return "privacy"
            default:
                return "error"
            }
        }
        return "error"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.section == 0 && indexPath.row == 0 {
            //O2Nav.showUser(Local.USER.name!)
//            let cont = AlbumViewController(nibName: "AlbumViewController", bundle: nil)
//            cont.setUser(Local.USER.name!)
//            cont.title = "相册"
//            cont.enableDelete = true
//            O2Nav.pushViewController(cont)
        }
        if indexPath.section == 1 && indexPath.row == 0 {
//            let cont =  sb.instantiateViewControllerWithIdentifier("orderlist") as! OrderedListViewController
            let cont = ProfileInfoController(style: UITableViewStyle.Grouped)
            self.navigationController?.pushViewController(cont, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 2 {
            let cont = AlbumViewController(nibName: "AlbumViewController", bundle: nil)
            cont.setUser(Local.USER.name!)
            cont.title = "相册"
            cont.enableDelete = true
            cont.enableAdd = false
            O2Nav.pushViewController(cont)
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            let cont =  sb.instantiateViewControllerWithIdentifier("orderlist") as! OrderedListViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 3 && Local.USER.iscoach {
            let cont =  sb.instantiateViewControllerWithIdentifier("workingtimeconfig") as! WorkingTimeConfigViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 4 && Local.USER.iscoach {
            
            let cont =  sb.instantiateViewControllerWithIdentifier("workinghourconfig") as! WorkingHourConfigViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 5 && Local.USER.iscoach {
            
            let cont =  sb.instantiateViewControllerWithIdentifier("myproduct") as! MyProductViewController
            self.navigationController?.pushViewController(cont, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 6 && Local.USER.iscoach {
            
            let cont =  IncomeController()
            self.navigationController?.pushViewController(cont, animated: true)
        }
        
        
        if indexPath.section == 2 && indexPath.row == 0{
            let cont =  AboutController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(cont, animated: true)
            
        }
        if indexPath.section == 2 && indexPath.row == 1{
           O2Nav.showProtocol()
        }
    }
}

extension ProfileViewController : FSMediaPickerDelegate {
    
    func mediaPicker(mediaPicker: FSMediaPicker!, didFinishWithMediaInfo mediaInfo: [NSObject : AnyObject]!) {
        let image : UIImage = mediaInfo["UIImagePickerControllerEditedImage"] as! UIImage
        var ratio:CGFloat = 1
        let imgdata = UIImageJPEGRepresentation(image, 1)!
        if imgdata.length/1024 > 50 {
            ratio = CGFloat(100)/CGFloat(imgdata.length/1024)
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
