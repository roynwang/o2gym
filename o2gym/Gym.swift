//
//  Gym.swift
//  o2gym
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Gym : BaseDataItem{
    public var id:Int
    public var name:String
    public var introduction:String? = nil
    public var imgs:String? = nil
    public var img_set:[String] = []
    
    
    override var type:String {
        return "gym"
    }
    
    override var UrlCreate:String {
        return Host.GymCreate()
    }
    
    override var UrlGet:String {
        return Host.GymGet(self.id)
    }
    
    init(id:Int, name:String, introduction:String?, imgs:String?){
        self.id = id
        self.name = name
        self.introduction = introduction
        self.imgs = imgs
 
    }
    
    public convenience init(dict:JSON){
        self.init(id:dict["id"].intValue,
            name:dict["name"].stringValue,
            introduction:dict["introduction"].string,
            imgs:dict["imgs"].string
        )
        self.load_img_set()
        
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
        self.load_img_set()
    }
    
}