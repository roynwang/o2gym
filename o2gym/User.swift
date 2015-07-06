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
    
    override var UrlCreate:String {
        return Host.UserCreate()
    }
    override var UrlGet:String {
        return Host.UserGet(self.name!)
    }
    
    public init(id: Int?, name:String?, iscoach:Bool?){
        self.id = id
        self.name = name
        if iscoach != nil {
            self.iscoach = iscoach!
        }
    }
    
    public override convenience init(){
        self.init(id: nil, name: nil, iscoach: false)
    }
    
    public convenience init(name:String){
        self.init(id: nil, name: name, iscoach: false)
    }
    public convenience init(id:Int, name:String){
        self.init(id: id, name: name, iscoach: false)
    }
     public override func buildParam()->[String:String]{
        return [ "name": self.name!, "iscoach": self.iscoach.toString()]
    }
    
    public override func loadFromJSON(dict:JSON){
        self.id = dict["id"].int
        self.name = dict["name"].string
    }
    

}
