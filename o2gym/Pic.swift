//
//  Pic.swift
//  o2gym
//
//  Created by xudongbo on 7/15/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class Pic : BaseDataItem{
    var id:Int!
    var url:String!
    

    override var type:String {
        return "pic"
    }
    
    public override init(){
        self.id = nil
        self.url = nil
    }
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].int
        self.url = dict["url"].string
    }

}