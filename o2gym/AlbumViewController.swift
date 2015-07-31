//
//  CollectionViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

let reuseIdentifier = "piccell"

public class AlbumViewController: UICollectionViewController {
    
    public var usrname:String!
    public var album:Album!
    var picWidth:CGFloat!
    var isSelf:Bool = false
    
    public func setUser(name:String){
        self.usrname = name
        self.album = Album(name: name)
        self.load(nil)
    }
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!, usrname:String) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.usrname = usrname
        self.album = Album(name: self.usrname)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isSelf = (self.usrname == Local.USER.name)
        
        let framewidth = CGRectGetWidth(self.collectionView!.frame)
        
        self.picWidth = (framewidth - 20)/3
        
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
    }
    
    func segmentTitle()->String{
        return "相册"
    }
    
    public func load(callback:(()->Void)?){
        self.album.load({
            self.collectionView!.reloadData()
            if callback != nil{
                callback!()
            }
            }, itemcallback: nil)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
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
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.isSelf ? (self.album.count + 1 ): self.album.count
    }
    
    public override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 && self.isSelf{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("picaddcell", forIndexPath: indexPath) as! AlbumPicAddCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("piccell", forIndexPath: indexPath) as! AlbumPicCell
            var i = indexPath.row
            if self.isSelf {
                i -= 1
            }
            let pic = self.album.datalist[i] as! Pic
            cell.Img.load(pic.url, placeholder: nil) { (_, uiimg, err) -> () in
                cell.Img.image = Helper.RBSquareImage(uiimg!)
            }
            println(pic.url)
            return cell
        }
    }
    
    public override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if self.isSelf && indexPath.row == 0 {
           let sb = UIStoryboard(name: "Main", bundle: nil)
           let v = sb.instantiateViewControllerWithIdentifier("newpost") as! WeiboPostViewController
            //just for trigger viewDidLoad
            let p = v.view
           self.navigationController?.pushViewController(v, animated: true)
        } else {
            let i = self.isSelf ? (indexPath.row-1):indexPath.row
            let photo = self.album.datalist[i] as! Pic
            let cell = self.collectionView?.cellForItemAtIndexPath(indexPath)
            
            PicViewer.showPic(photo.url, source: cell!, parent: self.view, controller: self)
            
        }
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
