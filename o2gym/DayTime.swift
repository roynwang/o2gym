//
//  DayTime.swift
//  o2gym
//
//  Created by xudongbo on 9/2/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation



public class DayTime : BaseDataItem{
    public var name:String!
    public var date:String!
    public var na:[Int] = []
    public var availiable:[Int] = []
    public var out:[Int] = []
    public var noon:[Int] = []

    override var UrlGet:String {
        return Host.DayTimeGet(self.name!, date: self.date)
    }

    public convenience init(name:String, date:String){
        self.init()
        self.name = name
        self.date = date
    }
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        dict["na"].arrayValue.map({self.na.append(Int($0.stringValue)!)})
        dict["availiable"].arrayValue.map({self.availiable.append(Int($0.stringValue)!)})
        dict["out"].arrayValue.map({self.out.append(Int($0.stringValue)!)})
        dict["noon"].arrayValue.map({self.noon.append(Int($0.stringValue)!)})
    }
    
}