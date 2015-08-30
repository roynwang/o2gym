    //
//  FeedStreamViewController.swift
//  o2gym
//
//  Created by xudongbo on 7/21/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class FeedStreamViewController: UITableViewController {
    
    let toastheight:CGFloat = 40
    
    var feed: Feed!
    var tips: UIView!
    var executing:Bool = false
    var updatetoast:UILabel!
    var nomore:Bool = false
    //var UserDetail:UserDetailViewController = UserDetailViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "FeedPicViewCell", bundle: nil), forCellReuseIdentifier: "feedpicviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedArticleViewCell", bundle: nil), forCellReuseIdentifier: "feedarticleviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedMultPicViewCell", bundle: nil), forCellReuseIdentifier: "feedmultpicviewcell")
        self.tableView.registerNib(UINib(nibName: "FeedCoachViewCell", bundle: nil), forCellReuseIdentifier: "feedcoachviewcell")
        
        //self.tableView.frame.size.width = 500
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("loadNew"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        self.feed = Local.FEED

        //notification
        updatetoast = UILabel(frame: CGRect(x: 0, y: -toastheight, width: self.tableView.frame.width, height: toastheight))
        updatetoast.backgroundColor = O2Color.UpdateToast
        updatetoast.textColor = UIColor.whiteColor()
        updatetoast.font = UIFont(name: updatetoast.font.fontName, size: 14)
        updatetoast.textAlignment = NSTextAlignment.Center;
        
        //self.tableView.scrollsToTop = false
        
        
        //self.view.addSubview(self.tips)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func showUpdateToast(num:Int){
        //if num <= 0 { return }
        updatetoast.text = StringResource.UpdateToastText(num)
        self.view.addSubview(updatetoast)
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.updatetoast.frame.origin.y = 0
            }, completion: { (_) -> Void in
                UIView.animateWithDuration(0.5, delay: 3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.updatetoast.frame.origin.y = -self.toastheight
                    self.executing = false
                    }, completion:{ (_) -> Void in
                        self.updatetoast.removeFromSuperview()
                })
        })

    }
    
    func loadNew(){
        if self.executing {
            self.refreshControl?.endRefreshing()
            return
        }
        self.executing = true
        
        func addlatest(){
           
            self.refreshControl?.endRefreshing()
           
             self.tableView.reloadData()
            
            self.showUpdateToast(self.feed.delta)
        }
    
        Local.FEED?.loadLatest(addlatest, onfail: nil)
    }
    
    func loadOld() {
        if self.nomore || self.executing {
            return
        }
        self.executing = true
        
        func addlatest(){
            self.executing = false
            if self.feed.delta == 0 {
                self.nomore = true
                return
            }
            self.tableView.reloadData()
            
            //self.showUpdateToast(self.feed.delta)
        }
        Local.FEED?.loadHistory(addlatest, itemcallback: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.feed.count
    }

    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {
            self.loadOld()
        }
    }
    
    
//    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
//        println(indexPath.row)
//    }
    func getCellIdentifier(weibo:Weibo) ->String{
        if weibo.coach != nil || (weibo.isfwd && weibo.fwdcontent!.coach != nil) {
            return "coach"
        }
        if weibo.islong || (weibo.isfwd && weibo.fwdcontent!.islong){
            return "article"
        }

        return "weibo"
    }
    
//    func showdUserDetail(name:String){
//        self.navigationController?.pushViewController(self.UserDetail, animated: true)
//    }
    
    func tapped(gr:UITapGestureRecognizer){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cont =  sb.instantiateViewControllerWithIdentifier("articledetail") as! ArticleDetailViewController
        cont.weiboid = gr.view!.tag
        cont.hidesBottomBarWhenPushed = true
        O2Nav.pushViewController(cont)

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let weibo = self.feed.datalist[indexPath.row] as! Weibo
        
        let celltype = self.getCellIdentifier(weibo)
        switch celltype {
            case "article":
                let cell = tableView.dequeueReusableCellWithIdentifier("feedarticleviewcell", forIndexPath: indexPath) as! FeedArticleViewCell
                
                cell.fillCard(weibo)
                cell.tag = weibo.isfwd ? weibo.fwdfrom! : weibo.id!
                var tapped:UITapGestureRecognizer = UITapGestureRecognizer()
                tapped.addTarget(self, action: "tapped:")
                cell.addGestureRecognizer(tapped)
                return cell
            case "weibo":
                let cell = tableView.dequeueReusableCellWithIdentifier("feedmultpicviewcell", forIndexPath: indexPath) as! FeedMultPicViewCell
                cell.fillCard(weibo)
                return cell
            case "coach":
                let cell = tableView.dequeueReusableCellWithIdentifier("feedcoachviewcell", forIndexPath: indexPath) as! FeedCoachViewCell
                cell.fillCard(weibo)
                return cell
            default:
                return UITableViewCell()
        }
        

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
