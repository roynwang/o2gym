//
//  WeekBookList.swift
//  o2gym
//
//  Created by xudongbo on 8/30/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class WeekBookList:BaseDataList {
    
    let coachname:String!
    var date:String!
    
    
    
    public init(name:String, date:String){
        self.coachname = name
        self.date = date.stringByReplacingOccurrencesOfString("/", withString: "")
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Book(dict: dict)
    }
    override var Url:String{
        //return Host.AlbumGet(self.usrname).
        return Host.WeekBookedGet(self.coachname, date:self.date)
    }
    override var listkey:String?{
        return nil
    }
}