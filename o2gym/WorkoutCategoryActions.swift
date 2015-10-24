//
//  WorkoutCategory.swift
//  o2gym
//
//  Created by xudongbo on 10/19/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation


public class WorkoutCategoryActions:BaseDataList{
    var usrname:String!
    var category:Int!
    public init(name:String,category:Int){
        self.usrname = name
        self.category = category
    }
    override func loaditem(dict: JSON) -> BaseDataItem {
        return WorkoutAction(dict: dict)
    }
    override var Url:String{
        return Host.WorkoutCategoryActions(self.category, name: self.usrname)
    }
    override var listkey:String?{
        return nil
    }
}