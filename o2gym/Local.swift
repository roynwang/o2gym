//
//  Local.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Local{
    
    static var _usr:User? = nil
    static var _timelne:Timeline? = nil
    
    public class func login(onsuccess :((User)->Void)?,onfail :((String)->Void)?){
        let defaults = NSUserDefaults.standardUserDefaults()
        let name:String = defaults.stringForKey("o2gym_name")!
        self._usr = User(name: name)
        self._timelne = Timeline(name: name)
   
        self.TIMELINE.loadRemote(nil, onfail: nil)
        
        self.USER.loadRemote(onsuccess, onfail: onfail)
        
    }
   
    public static var USER:User{
        return Local._usr!
    }
    public static var TIMELINE:Timeline{
        return Local._timelne!
    }
    
    public static var FEED:Feed? = nil
    
    public static var RECOMMEND:RecommendList? = nil
}