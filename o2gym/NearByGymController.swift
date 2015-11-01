//
//  NearByGymController.swift
//  o2gym
//
//  Created by xudongbo on 9/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit
import CoreLocation

class NearByGymController: UITableViewController, CLLocationManagerDelegate {

    
    var gymNearBy : NearByGyms!
    var locationManager : CLLocationManager!
    var refreshcontrol : UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerNib(UINib(nibName: "NearByGymCell", bundle: nil), forCellReuseIdentifier: "nearbygym")
        
        self.tableView.separatorStyle = .None
        self.gymNearBy = NearByGyms()
        
        
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        else{
            print("Location service disabled");
        }
        self.navigationController?.navigationBar.translucent = false
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
//         = refreshControl
    }
    func refresh(){
        self.gymNearBy = NearByGyms()
        self.locationManager.startUpdatingLocation()
        self.locationManager(self.locationManager, didUpdateLocations: [])
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if manager.location == nil {
            self.refreshControl?.endRefreshing()
            self.view.makeToast(message: "无法定位，请检查设置或者稍后再试")
            return
        }
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        self.gymNearBy.setLoc("\(locValue.longitude)", latitude: "\(locValue.latitude)")
        self.gymNearBy.load({ () -> Void in
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            manager.stopUpdatingLocation()
            }, itemcallback: nil)
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if !self.gymNearBy.isLoaded {
            return 0
        }
        return self.gymNearBy.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 166
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nearbygym", forIndexPath: indexPath) as! NearByGymCell

        if self.gymNearBy != nil && (indexPath.row < self.gymNearBy.count ){
            let gym = self.gymNearBy.datalist[indexPath.row] as! Gym
            cell.setGym(gym)
        }
        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let gym = self.gymNearBy.datalist[indexPath.row] as! Gym
        O2Nav.showGym(gym.id)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
