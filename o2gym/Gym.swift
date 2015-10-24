//
//  Gym.swift
//  o2gym
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Gym : BaseDataItem{
    public var id:Int!
    public var name:String!
    public var address:String!
    public var introduction:String? = nil
    public var imgs:String? = nil
    public var img_set:[String] = []
    public var distance:Int!
    public var coaches:[User] = []
    public var location:String!
    public var phone:String!
    public var mappic:String!
    
    
    override var type:String {
        return "gym"
    }
    
    override var UrlCreate:String {
        return Host.GymCreate()
    }
    
    override var UrlGet:String {
        return Host.GymGet(self.id)
    }
    
    public convenience init(id:Int){
        self.init()
        self.id = id
    }
        
    public convenience init(dict:JSON){
        self.init(id:dict["id"].intValue)
        self.loadFromJSON(dict)
  
    }
    
    func load_img_set(){
        if let dataFromString = self.imgs!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            for item in json.arrayValue {
                self.img_set.append(item.stringValue)
            }
        }
    }
    
    
    public override func loadFromJSON(dict:JSON){
        self.id = dict["id"].intValue
        self.name = dict["name"].stringValue
        self.introduction = dict["introduction"].string
        self.imgs = dict["imgs"].string
        self.address = dict["address"].string
        for item in dict["coaches_set"].arrayValue {
            self.coaches.append(User(dict: item))
        }
        self.distance = dict["distance"].int
        self.location = dict["location"].string
        self.phone = dict["phone"].string
        self.load_img_set()
        self.mappic = "http://restapi.amap.com/v3/staticmap?markers=mid,0xFF0000,:" + self.location + "&key=a2be60fd9e30425d8e7c003ba81a1f12&size=600*600"
    }
    
}