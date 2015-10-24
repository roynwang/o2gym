//
//  CollectionViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

let reuseIdentifier = "piccell"

public class AlbumViewController: UICollectionViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var rydelegate:RYProfileViewDelegate!
    
    
    
    public var usrname:String!
    public var album:Album!
    public var enableDelete:Bool = false
    
    var minHeight:CGFloat!
    var picWidth:CGFloat!
    var isSelf:Bool = false
    var executing:Bool = false
    var nomore:Bool = false
    var started:Bool = false
    //var allpics:[UIImageView] = []
    
    var emptyStr:NSAttributedString!
    
    
    public func setUser(name:String){
        self.usrname = name
        self.album = Album(name: name)
        self.load { () -> Void in
            //self.allpics
        }
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //    public convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
    //        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    ////        self.usrname = usrname
    ////        self.album = Album(name: self.usrname)
    //    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isSelf = (Local.HASLOGIN && self.usrname == Local.USER.name)
        
        
        //let framewidth = CGRectGetWidth(self.collectionView!.frame)
        
        
        //self.album = Album(name:self.usrname)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "AlbumPicCell", bundle: nil), forCellWithReuseIdentifier: "piccell")
        self.collectionView!.registerNib(UINib(nibName: "AlbumPicAddCell", bundle: nil), forCellWithReuseIdentifier: "picaddcell")
        self.hidesBottomBarWhenPushed = true
        //self.load(nil)
        // Do any additional setup after loading the view.
        let attributes = [
            NSFontAttributeName : UIFont(name: "RTWS YueGothic Trial", size: 20)!,
            NSForegroundColorAttributeName : UIColor.lightGrayColor()]
        self.emptyStr = NSAttributedString(string:"...载入中...", attributes:attributes)
        
        self.collectionView?.bounces = true
        //self.collectionView?.alwaysBounceHorizontal = true
        self.collectionView?.alwaysBounceVertical = true
        
        
        self.collectionView!.emptyDataSetSource = self
        self.collectionView!.emptyDataSetDelegate = self
        
        
    }
    
    
    public func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return self.emptyStr
    }
    
    public func verticalOffsetForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return -150
    }
    
    func segmentTitle()->String{
        return "相册"
    }
    func streachScrollView()->UIScrollView{
        return self.collectionView!
    }
    
    public func load(callback:(()->Void)?){
        
        self.album.load({
            self.started = true
            self.collectionView!.reloadData()
            if callback != nil{
                callback!()
            }
            let attributes = [
                NSFontAttributeName : UIFont(name: "RTWS YueGothic Trial", size: 20)!,
                NSForegroundColorAttributeName : UIColor.lightGrayColor()]
            self.emptyStr = NSAttributedString(string:"还没有照片", attributes:attributes)
            self.collectionView!.reloadEmptyDataSet()
            
            }, itemcallback:nil)
        
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let framewidth = self.view.frame.width
        self.picWidth = (framewidth - 20)/3
        return CGSizeMake(self.picWidth, self.picWidth)
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    
    
    
    public override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    public override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        var count  = 0
        //#warning Incomplete method implementation -- Return the number of items in the section
        if self.album != nil {
            count = self.album.count
        }
        if self.isSelf {
            count += 1
        }

        return count
    }
    
    public override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row == self.collectionView(collectionView, numberOfItemsInSection: 0) - 1  && self.minHeight != nil{
            self.collectionView?.contentSize = CGSize(width: self.view.frame.width, height: self.minHeight)
        }
        
        if indexPath.row == 0 && self.isSelf{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("picaddcell", forIndexPath: indexPath) as! AlbumPicAddCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("piccell", forIndexPath: indexPath) as! AlbumPicCell
            cell.Del.hidden = !enableDelete
            var i = indexPath.row
            if self.isSelf {
                i -= 1
            }
            if i < self.album.count {
                let pic = self.album.datalist[i] as! Pic
                cell.Img.fitLoad(pic.url, placeholder: nil)
            } else {
                print("add place holder")
            }
            cell.tag = i
            cell.DelBtn.addTarget(self, action: "delPic:", forControlEvents: .TouchUpInside)
            
            return cell
        }
    }
    func delPic(btn:UIButton){
        let alert = SIAlertView(title: "确认删除", andMessage: "删除后图片将不能恢复")
        alert.addButtonWithTitle("删除", type: SIAlertViewButtonType.Default, handler: { (_) -> Void in
            alert.dismissAnimated(true)
            
            var i = btn.tag
            self.collectionView!.makeToastActivityWithMessage(message: "正在删除")
            let pic = self.album.datalist[i] as! Pic
            pic.delete({ (_) -> Void in
                self.collectionView!.hideToastActivity()
                self.collectionView!.makeToast(message: "已删除")
                self.album.datalist.removeAtIndex(i)
                if self.isSelf {
                    i += 1
                }
                print(NSIndexPath(forRow: i, inSection: 0))
                self.collectionView?.deleteItemsAtIndexPaths([NSIndexPath(forRow: i, inSection: 0)])

                }, onfail: { (msg) -> Void in
                    self.collectionView!.hideToastActivity()
                    self.collectionView!.makeToast(message: "删除失败")
            })
        })
        alert.addButtonWithTitle("取消", type: .Cancel) { (_) -> Void in
            alert.dismissAnimated(true)

        }
        alert.show()
    }
    
    public override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if self.isSelf && indexPath.row == 0 {
            
            let picker = FSMediaPicker()
            picker.editMode = FSEditModeNone
            picker.delegate = self
            picker.showFromView(self.collectionView)
        } else {
            
            let browser = SDPhotoBrowser()
            browser.sourceImagesContainerView = self.collectionView?.cellForItemAtIndexPath(indexPath)
            browser.imageCount = self.album.count
            browser.delegate = self
            
            let i = self.isSelf ? (indexPath.row-1) : indexPath.row
            browser.currentImageIndex = Int32(i)
            browser.show()
            
            //O2Nav.controller.presentViewController(photosViewController, animated: true, completion: nil)
            
        }
    }
    
    
    override public func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.started == false {
            return
        }
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {
            self.loadOld()
        }
        if self.rydelegate != nil {
            self.rydelegate.RYscrollViewDidScroll(scrollView)
        }
        
    }
    
    func loadOld() {
        if self.nomore || self.executing {
            return
        }
        self.executing = true
        
        func addlatest(){
            self.executing = false
            if self.album.delta == 0 {
                self.nomore = true
                return
            }
            self.collectionView!.reloadData()
            
            self.collectionView?.collectionViewLayout.prepareLayout()
            
            //self.showUpdateToast(self.feed.delta)
        }
        self.album.loadHistory(addlatest, itemcallback: {(item) -> Void in
            //let img = UIImageView(frame:CGSizeMake(self.picWidth, self.picWidth))
            //img.loadUrl((item as! Pic).url)
            //self.allpics.append(img)
        })
    }
    
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}

extension AlbumViewController : SDPhotoBrowserDelegate{
    public func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        return NSURL(string:(self.album.datalist[index] as! Pic).url)
    }
    public func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        var tarIndex = index
        if self.isSelf {
            tarIndex += 1
        }
        let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow: tarIndex, inSection: 0))
        return (cell as! AlbumPicCell).Img.image!
    }
}

extension AlbumViewController : FSMediaPickerDelegate {
    
    
    
    public func mediaPicker(mediaPicker: FSMediaPicker!, didFinishWithMediaInfo mediaInfo: [NSObject : AnyObject]!) {
        let image : UIImage = mediaInfo["UIImagePickerControllerOriginalImage"] as! UIImage
        var ratio:CGFloat = 1
        let imgdata = UIImageJPEGRepresentation(image, 1)!
        if imgdata.length/1024 > 50 {
            ratio = CGFloat(100)/CGFloat(imgdata.length/1024)
        }
        //Local.USER.avatar = "test"
        //let nsdata = NSData(
        Helper.upload(UIImageJPEGRepresentation(image,ratio)!, complete: { (info, filename, resp) -> Void in
            let img = Host.ImgHost + filename
            let post = Weibo(usr: Local.USER)
            post.setContent("新照片", brief: "", imgs: "[\"\(img)\"]")
            post.save({ (_) -> Void in
                print("saved ... ...")
                self.album.datalist.insert(Pic(url:img), atIndex: 0)
                self.collectionView?.reloadData()
                }, error_handler: nil)
        })
        
    }
    
}


