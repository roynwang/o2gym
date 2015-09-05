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
    public var upped_person:[String] = []
    public var upnum:Int = 0
    public var gym:String! = ""
    public var displayname:String!
    
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
        self.init()
        self.loadFromJSON(dict)
        
    }
    
    public convenience init(name:String){
        self.init(id: nil, name: name, iscoach: false, avatar: nil)
    }
    public convenience init(id:Int, name:String){
        self.init(id: id, name: name, iscoach: false, avatar: nil)
    }
     public override func buildParam()->[String:String]{
        return [
            "displayname": self.displayname,
            "avatar" : self.avatar!
        ]
    }
    
    public override func loadFromJSON(dict:JSON){
        self.id = dict["id"].int
        self.name = dict["name"].string
        self.iscoach = dict["iscoach"].boolValue
        self.avatar = dict["avatar"].string
        self.upnum = dict["upnum"].intValue
        self.displayname = dict["displayname"].stringValue
        dict["upped"].arrayValue.map({self.upped.append($0.intValue)})
        dict["fwded"].arrayValue.map({self.fwded.append($0.intValue)})
        dict["commented"].arrayValue.map({self.commented.append($0.intValue)})
        dict["upped_person"].arrayValue.map({self.upped_person.append($0.stringValue)})
        if dict["gym"].array != nil && dict["gym"].array?.count>0{
            self.gym = dict["gym"].arrayValue[0].stringValue
        }
    }
    
    public func up(name:String, direction:Bool = true){
        if direction {
            self.upnum=self.upnum + 1
            self.requestGet(Host.UserUp(self.name!, name:name), onsuccess: nil, onfail: nil)
            self.setUpped(name)
            
        } else {
            self.upnum=self.upnum - 1
            self.requestGet(Host.UserUp(self.name!, name:name,up:false), onsuccess: nil, onfail: nil)
            self.setUpped(name,up: false)
        }
    }
    
    func setUpped(name:String, up:Bool = true){
        if up {
            if let index = find(self.upped_person, name) {
                self.upped_person.append(name)
            }
        }
        else {
            if let index = find(self.upped_person, name) {
                self.upped_person.removeAtIndex(index)
            }
        }
    }
    func follow(name:String, onsuccess:()->Void){
        self.requestGet(Host.Follow(self.name!, follows: name), onsuccess: onsuccess, onfail: nil)
    }
}
