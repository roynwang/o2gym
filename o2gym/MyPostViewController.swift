//
//  MyPostViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit



public class MyPostViewController: UITableViewController {
    
    var usrname:String!
    var mypost:MyPost!
    var isSelf:Bool = false
    var executing:Bool = false
    var nomore:Bool = false
    
    public func setUser(name:String){
        self.usrname = name
        self.mypost = MyPost(name: name)
        
    }
    public required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!, usrname:String) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.usrname = usrname
        self.mypost = MyPost(name: self.usrname)
        
    }
    public override func viewWillAppear(animated: Bool) {
           }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.mypost.load(nil, itemcallback: nil)
        self.tableView.registerNib(UINib(nibName: "FeedPicViewCell", bundle: nil), forCellReuseIdentifier: "feedpicviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedArticleViewCell", bundle: nil), forCellReuseIdentifier: "feedarticleviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedMultPicViewCell", bundle: nil), forCellReuseIdentifier: "feedmultpicviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedCoachViewCell", bundle: nil), forCellReuseIdentifier: "feedcoachviewcell")
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.load(nil)
        self.hidesBottomBarWhenPushed = true
        if self.usrname == Local.USER.name {
            self.isSelf = true
        }
        self.tableView.backgroundColor = O2Color.BgGreyColor
        self.load { () -> Void in
            self.tableView.reloadData()
        }

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    public func loadHistory(callback:(()->Void)?){
        self.mypost.loadHistory({
            self.tableView.reloadData()
            if callback != nil{
                callback!()
            }
            }, itemcallback: nil)
    }
    public func load(callback:(()->Void)?){
        self.mypost.load({
            self.tableView.reloadData()
            if callback != nil{
                callback!()
            }
            }, itemcallback: nil)
    }
    
    func resizeTable(){
        
        let height = self.tableView.contentSize.height;
        
        // if the height of the content is greater than the maxHeight of
        // total space on the screen, limit the height to the size of the
        // superview.
        
        // now set the height constraint accordingly
        
        self.tableView.frame = CGRect(
            x: self.tableView.frame.origin.x,
            y: self.tableView.frame.origin.y,
            width: self.tableView.frame.width,
            height: height)
        
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func segmentTitle()->String{
        return "氧气罐"
    }
    func streachScrollView()->UIScrollView{
        return self.tableView
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.mypost.count
    }
    func getCellIdentifier(weibo:Weibo) ->String{
        if weibo.coach != nil || (weibo.isfwd && weibo.fwdcontent!.coach != nil) {
            return "coach"
        }
        if weibo.islong || (weibo.isfwd && weibo.fwdcontent!.islong){
            return "article"
        }
        
        return "weibo"
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let weibo = self.mypost.datalist[indexPath.row] as! Weibo
        
        let celltype = self.getCellIdentifier(weibo)
        switch celltype {
        case "article":
            let cell = tableView.dequeueReusableCellWithIdentifier("feedarticleviewcell", forIndexPath: indexPath) as! FeedArticleViewCell
            cell.fillCard(weibo, isSelf:self.isSelf, timeline: [13,7])
            return cell
        case "weibo":
            let cell = tableView.dequeueReusableCellWithIdentifier("feedmultpicviewcell", forIndexPath: indexPath) as! FeedMultPicViewCell
            cell.fillCard(weibo, isSelf:self.isSelf, timeline: [13,7])
            return cell
        case "coach":
            let cell = tableView.dequeueReusableCellWithIdentifier("feedcoachviewcell", forIndexPath: indexPath) as! FeedCoachViewCell
            cell.fillCard(weibo, isSelf:self.isSelf, timeline: [13,7])
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    override public func scrollViewDidScroll(scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {
            self.loadOld()
        }
    }
    
    func loadOld() {
        if self.nomore || self.executing {
            return
        }
        self.executing = true
        
        func addlatest(){
            self.executing = false
            if self.mypost.delta == 0 {
                self.nomore = true
                return
            }
            self.tableView.reloadData()
            
            //self.showUpdateToast(self.feed.delta)
        }
        self.mypost.loadHistory(addlatest, itemcallback: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
