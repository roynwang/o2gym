//
//  RecommendItem.swift
//  o2gym
//
//  Created by xudongbo on 7/19/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class RecommendItem : BaseDataItem{
    public var recommendpic:String?
    public var recommendtitle:String?
    public var recommendcontent:BaseDataItem?
    public var recommendsubtitle:String?
    public var recommendloc:String?
    public var recommendprice:String?
    public var corner:String?
    
    
    override var type:String {
        return "recommend"
    }
    
    public override init(){
        self.recommendpic = nil
        self.recommendtitle = nil
        self.recommendcontent = nil
        self.recommendsubtitle = nil
        self.recommendloc = nil
        self.recommendprice = nil
        self.corner = nil
    }
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.recommendpic = dict["recommend_pic"].stringValue
        self.recommendtitle = dict["recommend_title"].stringValue
        self.recommendsubtitle = dict["recommend_subtitle"].string
        self.recommendprice = dict["recommend_price"].string
        self.recommendloc = dict["recommend_loc"].string
        self.corner = dict["corner"].string
        let type = dict["recommend_type"].stringValue
        switch(type){
        case "user":
            self.recommendcontent =  User(dict: dict["person_display"])
        case "article":
            self.recommendcontent =  Weibo(dict: dict["article_display"])
        case "gym":
            self.recommendcontent =  Gym(dict: dict["gym_display"])
        case "course":
            self.recommendcontent =  Course(dict: dict["course_display"])
        default:
            self.recommendcontent = nil
        }
    }
    
}

