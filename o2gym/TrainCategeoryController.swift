//
//  ViewController.swift
//  o2gym
//
//  Created by xudongbo on 10/19/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit

class TrainCategeoryController : UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var actionSelected:Int = -1
    var onActionSelected:((WorkoutAction)->Void)!
    
    var categeoryList:WorkoutCategoryList!
    var actionList:WorkoutCategoryActions!
    
    @IBOutlet weak var CategeoryHeight: NSLayoutConstraint!
    @IBOutlet weak var Categeory: UICollectionView!
    @IBOutlet weak var ActionDetail: UITableView!
    
    
    
    
    var categeoryWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Categeory.dataSource = self
        self.Categeory.delegate = self
        self.ActionDetail.delegate = self
        self.ActionDetail.dataSource = self
        self.categeoryList = WorkoutCategoryList()
        self.categeoryList.load({ () -> Void in
            self.Categeory.reloadData()
            }, itemcallback: nil)
        
        // Do any additional setup after loading the view.
        
        self.Categeory.registerNib(UINib(nibName: "TrainCategeoryCell", bundle: nil), forCellWithReuseIdentifier: "cate")
        
        self.ActionDetail.registerNib(UINib(nibName: "TrainActionCell", bundle: nil), forCellReuseIdentifier: "action")
        self.ActionDetail.registerNib(UINib(nibName: "NewActionCell", bundle: nil), forCellReuseIdentifier: "addnew")
 
        self.Categeory.backgroundColor = UIColor.whiteColor()
//        self.ActionDetail.separatorStyle = .None
        self.ActionDetail.rowHeight = 60
        self.ActionDetail.separatorColor = O2Color.BorderGrey
//        self.ActionDetail.topBorderWidth = 0.5
        self.ActionDetail.tableFooterView = UIView(frame: CGRect.zero)
        self.ActionDetail.tableHeaderView = UIView(frame: CGRectMake(0, 0, self.ActionDetail.frame.width, 0.5))
        self.ActionDetail.tableHeaderView?.backgroundColor = O2Color.BorderGrey
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let framewidth = self.view.frame.width
        self.categeoryWidth = (framewidth - 120)/5
        self.CategeoryHeight.constant = self.categeoryWidth + 20
        
        return CGSizeMake(self.categeoryWidth, 1.08*self.categeoryWidth)
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == self.actionList.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("addnew", forIndexPath: indexPath) as! NewActionCell
  
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("action", forIndexPath: indexPath) as! TrainActionCell
        let action = self.actionList.datalist[indexPath.row] as! WorkoutAction
        cell.Action.text = action.name
        cell.Muscle.text = action.muscle
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.actionList == nil {
            return 0
        }
        return self.actionList.count+1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cate", forIndexPath: indexPath) as! TrainCategeoryCell
        let cate = self.categeoryList.datalist[indexPath.row] as! WorkoutCategory
        cell.Action.text = cate.name
        cell.Icon.image = UIImage(named: "hexagon")
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.categeoryList == nil {
            return 0
        }
        return self.categeoryList.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.actionList = WorkoutCategoryActions(name: Local.USER.name!, category: (self.categeoryList.datalist[indexPath.row] as! WorkoutCategory).id)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TrainCategeoryCell
        self.actionSelected = indexPath.row
        cell.Icon.image = UIImage(named: "hexagon")?.add_tintedImageWithColor(O2Color.LightMainColor, style: ADDImageTintStyleKeepingAlpha)

        
        self.actionList.load({ () -> Void in
            self.ActionDetail.reloadData()
            }, itemcallback: nil)
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TrainCategeoryCell
        cell.Icon.image = UIImage(named: "hexagon")

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row  == self.actionList.count{
            let action = WorkoutAction()
            action.categeory = self.actionSelected
            self.onActionSelected(action)
        } else {
            let action = self.actionList.datalist[indexPath.row] as! WorkoutAction
            self.onActionSelected(action)
        }
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
