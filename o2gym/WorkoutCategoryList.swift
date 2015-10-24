//
//  WorkoutCategoryList.swift
//  o2gym
//
//  Created by xudongbo on 10/19/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation


public class WorkoutCategoryList:BaseDataList{
    override func loaditem(dict: JSON) -> BaseDataItem {
        return WorkoutCategory(dict: dict)
    }
    override var Url:String{
        return Host.WorkoutCategoryList()
    }
    override var listkey:String?{
        return nil
    }
    
    
}