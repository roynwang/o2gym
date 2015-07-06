//
//  Host.swift
//  o2gym
//
//  Created by xudongbo on 7/5/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

class Host {
    static let ip : String = "http://127.0.0.1:8000/api"
    class func WeiboGet(id: String) -> String {
        let url : String = "\(self.ip)/w/\(id)/"
        return url
    }
    class func WeiboCreate(by: String) -> String {
        let url : String = "\(self.ip)/\(by)/weibo/"
        return url
    }
    class func UserCreate() -> String{
        let url : String = "\(self.ip)/u/"
        print("===========\(url)==========")
        return url
    }
    
    class func UserGet(name:String) -> String {
        let url : String = "\(self.ip)/\(name)/"
        return url
    }
    
}
