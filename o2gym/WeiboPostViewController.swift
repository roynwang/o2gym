//
//  WeiboPostViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/17/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AVFoundation


class PostPics : NSObject, UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UIActionSheetDelegate,   LimCameraImagePickerDelegate{
    
    init(parent:UIViewController, tableview:UICollectionView){
        self.root = parent
        self.tableView = tableview
    }
    let root:UIViewController
    let tableView:UICollectionView
    var pics:[UIImage] = []
    var limPicker:LimCameraImagePicker?
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if indexPath.row == 0 {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("test", forIndexPath: indexPath) as! UICollectionViewCell
        // Configure the cell
        return cell
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pic", forIndexPath: indexPath) as! UICollectionViewCell
            // Configure the cell
            let img = Helper.RBSquareImageTo(self.pics[indexPath.row-1], size: CGSize(width: 50, height: 50))
            cell.addSubview(UIImageView(image:img))
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.pics.count + 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.showpickerimage(nil)
    }

    func addPic(pic:UIImage){
        self.pics.append(pic)
    }
    func addPics(pics:[UIImage]){
    }
    
    func removePic(pic:UIImage){
        //self.pics.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == kUTTypeImage as! String {
            limPicker = LimCameraImagePicker(nibName: "PickerView", bundle: NSBundle.mainBundle())
            limPicker!.setSourceType(picker.sourceType)
            var image = info[UIImagePickerControllerOriginalImage] as! UIImage
            limPicker!.addImage(image)
            limPicker!.delegate = self
            
            self.root.navigationController!.pushViewController(limPicker!, animated: true)
            picker.dismissViewControllerAnimated(true, completion: nil)
        } else {
            self.root.dismissViewControllerAnimated(true, completion: {})
            println("Video Taken!!!!");
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        println("Title : \(actionSheet.buttonTitleAtIndex(buttonIndex))")
        println("Button Index : \(buttonIndex)")
        
        if buttonIndex == 0 { return }
        
        let imageController = UIImagePickerController()
        imageController.editing = false
        imageController.delegate = self;
        
        if( buttonIndex == 1){
            imageController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if(buttonIndex == 2){
            imageController.sourceType = UIImagePickerControllerSourceType.Camera
            imageController.showsCameraControls = true
        } else {
            imageController.sourceType = UIImagePickerControllerSourceType.Camera
            imageController.mediaTypes = [kUTTypeMovie!]
            imageController.allowsEditing = false
            imageController.showsCameraControls = true
        }
        
        self.root.presentViewController(imageController, animated: true, completion: nil)
    }
    
    // MARK: - LimCameraImagePickerDelegate Methods
    
    func donePicking(picker: LimCameraImagePicker, didPickedUrls: [String]) {
        
        dispatch_async(dispatch_get_main_queue(), {
            // update some UI
            self.cleanProcessOnPicking()
        })
        
        //Do something with uploaded urls
        
    }
    func donePicking(picker: LimCameraImagePicker, didPickedUIImage: [UIImage]) {
        dispatch_async(dispatch_get_main_queue(), {
            // update some UI
            for pic in didPickedUIImage {
                self.pics.insert(pic, atIndex: 0)
            }
            self.tableView.reloadData()
            self.cleanProcessOnPicking()
        })
        println("llllllll")
    }
    
    func donePicking(picker: LimCameraImagePicker, didPicked: [String]) {
        
        dispatch_async(dispatch_get_main_queue(), {
            // update some UI
            
            self.cleanProcessOnPicking()
        })
        //Do something with uploaded urls
        
    }
    
    func cleanProcessOnPicking() {
        self.root.navigationController!.popViewControllerAnimated(true)
    }
    
    func cancelPicking(picker: LimCameraImagePicker) {
        self.root.navigationController!.popToViewController(self.root, animated: true)
    }
    
    @IBAction func showpickerimage(sender: AnyObject?) {
        var actionSheet:UIActionSheet
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,otherButtonTitles:"Select photo from library", "Take a picture", "Take a video")
        } else {
            actionSheet = UIActionSheet(title: nil , delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,otherButtonTitles:"Select photo from library")
        }
        actionSheet.delegate = self
        actionSheet.showInView(self.root.view)
    }
}

class WeiboPostViewController: UIViewController, UIScrollViewDelegate {
    

    var selectedPics:[NSData] = []
    var tabledelegate: PostPics? = nil

    @IBOutlet weak var weiboPic: UICollectionView!
    @IBOutlet weak var weiboText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weiboText.layer.borderWidth = 1
        var rightbtn:UIBarButtonItem = UIBarButtonItem(title: "right", style: UIBarButtonItemStyle.Plain, target: self, action: "publish")
      
        self.navigationItem.rightBarButtonItem = rightbtn
        
        self.tabledelegate = PostPics(parent: self, tableview: self.weiboPic)
    
        self.weiboPic.delegate = self.tabledelegate!
        self.weiboPic.dataSource = self.tabledelegate!
        // Do any additional setup after loading the view.
    }
    
    func publish(){
        let picount:Int = self.tabledelegate!.pics.count
        var done : Int = 0
        var picurls : [String] = []
        for pic in self.tabledelegate!.pics {
            let data = UIImageJPEGRepresentation(pic, 0.7)
            Helper.upload(data, complete: { (info, token, resp) -> Void in
                if info.ok {
                    print(resp["key"])
                    picurls.append(Host.ImgUrl(resp["key"] as! String))
                    done += 1
                }
                if done == picount {
                    let weibo:Weibo = Weibo(usr: Local.USER)
                    weibo.setContent("test", brief: "hahahah", imgs: Helper.arrayToJsonString(picurls))
                    weibo.save({ (t) -> Void in
                        println("finished")
                        let wb = t as! Weibo
                        println(wb.id)
                    }, error_handler: nil)
                    
                }
            })
        }
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
