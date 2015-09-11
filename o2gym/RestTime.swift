//
//  RestTime.swift
//  o2gym
//
//  Created by xudongbo on 9/1/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class RestTime : BaseDataItem{

    public var name:String!
    public var weekrest:[String]! = []
    public var excep_rest:[String]! = []
    public var excep_work:[String]! = []
    public var out_hours:[String]! = []
    public var noon_hours:[String]! = []
    
    
    override var UrlGet:String {
        return Host.RestTime(self.name!)
    }
    override var UrlCreate:String {
         return Host.RestTime(self.name!)
    }
    
    public init(name:String){
        super.init()
        self.name = name
    }
    public override init(){
        super.init()
    }
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.name = dict["name"].stringValue
        self.weekrest = dict["weekrest"].stringValue.componentsSeparatedByString("|").filter({$0 != ""})
        self.excep_rest = dict["excep_rest"].stringValue.componentsSeparatedByString("|").filter({$0 != ""})
        self.excep_work = dict["excep_work"].stringValue.componentsSeparatedByString("|").filter({$0 != ""})
        self.noon_hours = dict["noon_hours"].stringValue.componentsSeparatedByString("|").filter({$0 != ""})
        self.out_hours = dict["out_hours"].stringValue.componentsSeparatedByString("|").filter({$0 != ""})
    }
    public override func buildParam() -> [String : String] {
        return [
            "weekrest": "|".join(self.weekrest),
            "excep_rest": "|".join(self.excep_rest),
            "excep_work": "|".join(self.excep_work),
            "out_hours" : "|".join(self.out_hours),
            "noon_hours" : "|".join(self.noon_hours)
        ]
    }

    
}