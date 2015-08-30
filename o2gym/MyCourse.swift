//
//  MyCourse.swift
//  o2gym
//
//  Created by xudongbo on 8/13/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class MyCourse:BaseDataList {
    
    let usrname:String!
    
    public init(name:String){
        self.usrname = name
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Course(dict: dict)
    }
    override var Url:String{
        return Host.MyCourseGet(self.usrname)
    }
}