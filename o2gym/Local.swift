//
//  Local.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
import Alamofire

public class Local{
    
    static var _usr:User? = nil
    static var _timelne:Timeline? = nil
    static var _token:String? = ""
    static var _hasLogin:Bool = false
    
   
    
    
    static var AuthHeaders:[String:String] {
        if Local.TOKEN != "" {
            return ["Authorization":"JWT " + Local.TOKEN]
        }
        return [String:String]()
    }
    
    public static var paySuccess:(()->Void)?
    public static var payFail:(()->Void)?
    
    
    public class func loginWithVcode(phoneNum:String, vcode:String, onsuccess :((User)->Void)?,onfail :((String)->Void)?){
        let defaults = NSUserDefaults.standardUserDefaults()
        request(.GET, Host.VcodeLogin(phoneNum, vcode: vcode))
            .responseJSON { (req, resp, data) -> Void in
                if data.error != nil {
                    if onfail != nil {
                        onfail!("一个神奇的错误")
                    }
                    return
                }
                if resp?.statusCode == 200{
                    let dict = JSON(data.value!)
                    self._token = dict["token"].stringValue
                    print("==================")
                    print(self._token)
                    print("==================")
                    defaults.setValue(self._token, forKey: "o2gym_token")
                    defaults.setValue(phoneNum, forKey: "o2gym_name")
                    self._usr = User(name: phoneNum)
                    self._timelne = Timeline(name: phoneNum)
                    self.USER.loadRemote(onsuccess, onfail: onfail)
                    

                    //refresh token after 4 seconds
                    let delay = 4.0 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay)), dispatch_get_main_queue(), {
                        Local.auth(nil)
                    })
                } else {
                   
                    if onfail != nil {
                        onfail!("是不是验证码错了？检查一下或者重发")
                    }
                }
        }
    }
    
    
    
    public class func saveToken(usr:User, token:String){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(usr.name!, forKey: "o2gym_name")
        defaults.setValue(token, forKey: "o2gym_token")
    }
    
    
    public class func auth(onsuccess:(()->Void)!){
        
        if Local.HASLOGIN {
            return
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let token = defaults.stringForKey("o2gym_token")  {
            self._token = token
         
        }

        request(.POST, Host.TokenRefresh(), parameters:["token":Local.TOKEN])
        .validate()
        .responseJSON { (_, resp, result) -> Void in
            switch (result){
            case .Success(let data):
                self._hasLogin = true
                let js = JSON(data)
                if js["token"].string != nil {
                    self._token = js["token"].stringValue
                    
                    print("refreshed token")
                    print(self._token)
                    
                    defaults.setValue(self._token, forKey: "o2gym_token")
                    if self._usr  == nil {
                        self._usr = User(name: defaults.stringForKey("o2gym_name")!)
                        self._timelne = Timeline(name: defaults.stringForKey("o2gym_name")!)
                        Local.USER.loadRemote()
                    }
                    if onsuccess != nil {
                        onsuccess!()
                    }
                   
                } else {
                    self._hasLogin = false
                }
            case .Failure:
                self._hasLogin = false
            }
        }
    }
    
    public static var HASLOGIN:Bool {
        return Local._hasLogin
    }
    
    public static var USER:User{
        return Local._usr!
    }
    public static var TOKEN:String{
        if Local._token == nil {
            return ""
        }
        return Local._token!
    }
    public static var TIMELINE:Timeline{
        return Local._timelne!
    }
    
    public static var FEED:Feed? = nil
    
    public static var RECOMMEND:RecommendList? = nil
    
    public static var ORDERLIST: OrderList? = nil
    
    public static var CUSTOMERS : CustomerList? = nil
    
    public static var SCHEDULE : WeekBookList? = nil

    public static var TimeMap = ["09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00"]

}