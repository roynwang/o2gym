//
//  Timeline.swift
//  o2gym
//
//  Created by xudongbo on 7/27/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Timeline : BaseDataItem{
    public var id:Int? = nil
    public var name:String? = nil
    public var followedby:[Int] = []
    public var follows:[Int] = []
    
    override var UrlGet:String {
        return Host.TimelineGet(self.name!)
    }
    
    public init(name:String){
        self.name = name
    }
    
    public convenience init(dict:JSON){
        self.init(name:dict["name"].stringValue)
        self.loadFromJSON(dict)
    }
    public override func loadFromJSON(dict:JSON){
        self.id = dict["id"].intValue
        self.name = dict["name"].stringValue
        if dict["followedby"] != nil {
            dict["followedby"].arrayValue.map({self.followedby.append($0["id"].intValue)})
        }
        if dict["follows"] != nil {
            dict["follows"].arrayValue.map({self.follows.append($0["id"].intValue)})
        }
    }
    
    
}