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
    static var _token:String? = nil
    static var AuthHeaders = ["Authorization":"JWT " + Local.TOKEN]
    
    public class func login(onsuccess :((User)->Void)?,onfail :((String)->Void)?){
        let defaults = NSUserDefaults.standardUserDefaults()
        let name:String = defaults.stringForKey("o2gym_name")!
        let pwd:String = defaults.stringForKey("o2gym_pwd")!
        
        request(.POST, Host.JwtAuth(), parameters:["username":name, "password":pwd])
            .responseJSON { (req, resp, data, err) -> Void in
                if err != nil {
                    if onfail != nil {
                        onfail!("登陆失败")
                        
                    }
                    return
                }
                
                if resp?.statusCode == 200{
                    let dict = JSON(data!)
                    self._token = dict["token"].stringValue
                    
                    self._usr = User(name: name)
                    self._timelne = Timeline(name: name)
                    
                    self.TIMELINE.loadRemote(nil, onfail: nil)
                    
                    self.USER.loadRemote(onsuccess, onfail: onfail)
                    
                } else {
                    if onfail != nil {
                        onfail!("登陆失败")
                    }
                }
        }
    }
    
    public class func auth(username:String, pwd:String){

    }
    
    
    
    public static var USER:User{
        return Local._usr!
    }
    public static var TOKEN:String{
        return Local._token!
    }
    public static var TIMELINE:Timeline{
        return Local._timelne!
    }
    
    public static var FEED:Feed? = nil
    
    public static var RECOMMEND:RecommendList? = nil
    
    
    public static var TimeMap = ["09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00"]

}