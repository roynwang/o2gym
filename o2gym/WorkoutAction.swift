//
//  WorkoutAction.swift
//  o2gym
//
//  Created by xudongbo on 10/19/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation

public class WorkoutAction : BaseDataItem {
    public var id:Int!
    public var name:String!
    public var muscle:String!
    public var workouttype:String!
    public var units:String!
    public var categeory:Int!
    public var by:String!
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].int
        self.name = dict["name"].string
        self.muscle = dict["muscle"].string
        self.workouttype = dict["workouttype"].string
        self.units = dict["units"].string
        self.categeory = dict["categeory"].int
        self.by = dict["by"].string
    }
    
    public override var UrlCreate:String {
        print(self.buildParam())
        return Host.WorkoutCategoryActions(self.categeory, name: Local.USER.name!)
        
    }
    
    override func buildParam() -> [String : String] {
        return [
            "name":self.name,
            "muscle":self.muscle,
            "workouttype":"",
            "units":self.units,
            "categeory":self.categeory.toString(),
            "by":Local.USER.name!
        ]
    }
}
