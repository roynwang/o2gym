//
//  Course.swift
//  o2gym
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Course : BaseDataItem{
    
    public var id:Int
    public var title:String? = nil
    public var brief:String? = nil
    public var price:String? = nil
    public var gym:String? = nil
    public var pic:String? = nil
    
    
    override var type:String {
        return "course"
    }
    
    override var UrlCreate:String {
        return Host.CourseCreate()
    }
    
    override var UrlGet:String {
        return Host.CourseGet(self.id)
    }
    
    init(id:Int){
        self.id = id
    }
    
    public convenience init(dict:JSON){
        self.init(id:dict["id"].intValue)
        self.loadFromJSON(dict)
    }
    public override func loadFromJSON(dict: JSON) {
        self.title = dict["title"].stringValue
        self.brief = dict["brief"].string
        self.price = dict["price"].string
        self.gym = dict["gym"].string
        self.pic = dict["pic"].stringValue
    }
}