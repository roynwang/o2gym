//
//  WorkoutCategory.swift
//  o2gym
//
//  Created by xudongbo on 10/19/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation


public class WorkoutCategory : BaseDataItem {
    public var id:Int!
    public var name:String!
    public var icon:String!
    
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].int
        self.name = dict["name"].string
        self.icon = dict["icon"].string
    }
}