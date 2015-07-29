//
//  Person.swift
//  o2gym
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class User : BaseDataItem{
    public var id:Int? = nil
    public var name:String? = nil
    public var iscoach:Bool = false
    public var avatar:String? = nil
    public var upped:[Int] = []
    public var fwded:[Int] = []
    public var commented:[Int] = []
    
    override var type:String {
        return "user"
    }
    
    override var UrlCreate:String {
        return Host.UserCreate()
    }
    override var UrlGet:String {
        return Host.UserGet(self.name!)
    }
    
    public init(id: Int?, name:String?, iscoach:Bool?, avatar:String?){
        self.id = id
        self.name = name
        if iscoach != nil {
            self.iscoach = iscoach!
        }
        self.avatar = avatar
    }
    
    public override convenience init(){
        self.init(id: nil, name: nil, iscoach: false, avatar: nil)
    }
    public convenience init(dict:JSON){
        self.init(id:dict["id"].intValue,
            name:dict["name"].stringValue,
            iscoach:dict["iscoach"].boolValue,
            avatar:dict["avatar"].stringValue
        )
        
    }
    
    public convenience init(name:String){
        self.init(id: nil, name: name, iscoach: false, avatar: nil)
    }
    public convenience init(id:Int, name:String){
        self.init(id: id, name: name, iscoach: false, avatar: nil)
    }
     public override func buildParam()->[String:String]{
        return [ "name": self.name!, "iscoach": self.iscoach.toString()]
    }
    
    public override func loadFromJSON(dict:JSON){
        self.id = dict["id"].int
        self.name = dict["name"].string
        self.iscoach = dict["iscoach"].boolValue
        self.avatar = dict["avator"].string
        dict["upped"].arrayValue.map({self.upped.append($0.intValue)})
        dict["fwded"].arrayValue.map({self.fwded.append($0.intValue)})
        dict["commented"].arrayValue.map({self.commented.append($0.intValue)})
        println(self.upped)
    }
    

}
