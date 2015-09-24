//
//  NearByGyms.swift
//  o2gym
//
//  Created by xudongbo on 9/24/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation
//import CLLocationManager
import CoreLocation
public class NearByGyms:BaseDataList {
    
    var longitude:String!
    var latitude:String!
    

    func setLoc(longitude:String, latitude:String){
        self.longitude = longitude
        self.latitude = latitude
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Gym(dict: dict)
    }
    override var Url:String{
        //return Host.AlbumGet(self.usrname).
        return Host.NearByGymGet(self.longitude, latitude: self.latitude)
    }
    override var listkey:String?{
        return nil
    }

 }