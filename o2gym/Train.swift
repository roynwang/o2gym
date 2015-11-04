//
//  Train.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Train : BaseDataItem{
    public var id:Int!
    public var name:String!
    public var weight:String!
    public var repeattimes:String!
    public var groupid:Int!
    public var action_name:String!
    public var action_order:Int!
    public var date:String!
    public var units:String!
    public var tag:Int!

    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].int
        self.name = dict["name"].string
        self.weight = dict["weight"].string
        self.repeattimes = dict["repeattimes"].string
        self.groupid = dict["groupid"].int
        self.action_name = dict["action_name"].string
        self.action_order = dict["action_order"].int
        self.units = dict["units"].string
        self.date = dict["date"].string
    }
    public override func buildParam() -> [String : String] {
        return [
            "weight":self.weight ?? "",
            "repeattimes": self.repeattimes ?? "",
            "groupid": self.groupid.toString(),
            "action_name": self.action_name,
            "action_order": self.action_order.toString(),
            "units": self.units
        ]
    }
  }
