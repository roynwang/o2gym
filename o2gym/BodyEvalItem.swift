//
//  BodyEvalItem.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
public class BodyEvalItem : BaseDataItem{
    public var id:Int!
    public var option:String!
    public var value:String!
    public var group:String!
    public var unit:String!
    public var date:String!
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].int
        self.option = dict["option"].string
        self.value = dict["value"].string
        self.group = dict["group"].string
        self.unit = dict["unit"].string
        self.date = dict["date"].string
    }
    public override func buildParam() -> [String : String] {
        return [
            "option": self.option,
            "value": self.value,
            "group": self.group,
            "unit": self.unit
        ]
    }
}