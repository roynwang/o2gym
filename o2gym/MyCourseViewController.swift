//
//  MyCourseViewController.swift
//  o2gym
//
//  Created by xudongbo on 8/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

public class MyCourseViewController: UITableViewController {
    
    
    var usrname:String!
    var mycourse:MyCourse!

    var executing:Bool = false
    var nomore:Bool = false
    
    public func setUser(name:String){
        self.usrname = name
        self.mycourse = MyCourse(name: name)
        self.load(nil)
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
        self.mycourse = MyCourse(name: self.usrname)
        
    }
    
    public func loadHistory(callback:(()->Void)?){
        self.mycourse.loadHistory({
            self.tableView.reloadData()
            if callback != nil{
                callback!()
            }
            }, itemcallback: nil)
    }
    public func load(callback:(()->Void)?){
        self.mycourse.load({
            self.tableView.reloadData()
            if callback != nil{
                callback!()
            }
            }, itemcallback: nil)
    }
    
    public override func viewDidLoad() {

        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "RecommendCourseCell", bundle: nil), forCellReuseIdentifier: "recommendcoursecell")

        
        //self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = 167
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.load(nil)
        self.hidesBottomBarWhenPushed = true

        self.tableView.backgroundColor = O2Color.BgGreyColor
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segmentTitle()->String{
        return "课程"
    }
    func streachScrollView()->UIScrollView{
        return self.tableView
    }
    
    // MARK: - Table view data source
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
         return self.mycourse.count
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
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recommendcoursecell", forIndexPath: indexPath) as! RecommendCourseCell
        let course = self.mycourse.datalist[indexPath.row] as! Course
//
        cell.Img.load(course.pic!)
        cell.backgroundColor = UIColor.blackColor()
        cell.CourseTitle.text = course.title
        cell.SubTitle.text = course.brief
        cell.Location.text = course.gym
        // Configure the cell...
        
        return cell
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
