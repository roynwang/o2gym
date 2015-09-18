//
//  Recommend.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class RecommendList:BaseDataList {
    
    override var needAuth:Bool{
        return false
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem? {
        return RecommendItem(dict:dict)
//        let type = dict["recommend_type"].stringValue
//        switch(type){
//        case "user":
//            return User(dict: dict["person_display"])
//        case "article":
//            return Weibo(dict: dict["article_display"])
//        case "gym":
//            return Gym(dict: dict["gym_display"])
//        default:
//            return nil
//        }
    }
    override var Url:String{
        return Host.RecommendGet()
    }

}