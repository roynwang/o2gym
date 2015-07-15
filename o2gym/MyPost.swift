//
//  MyPost.swift
//  o2gym
//
//  Created by xudongbo on 7/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class MyPost:BaseDataList {
    
    let usrname:String!
    
    public init(name:String){
        self.usrname = name
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Weibo(dict: dict)
    }
    override var Url:String{
        return Host.MyPostGet(self.usrname)
    }
}
