//
//  GymList.swift
//  o2gym
//
//  Created by xudongbo on 10/15/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation


public class GymList:BaseDataList{

    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Gym(dict: dict)
    }
    override var Url:String{
        return Host.GymCreate()
    }
    override var listkey:String?{
        return nil
    }
}