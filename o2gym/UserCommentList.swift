//
//  UserCommentList.swift
//  o2gym
//
//  Created by xudongbo on 10/7/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation
public class UserCommentList:BaseDataList{
    let coachname:String!

    public init(name:String){
        self.coachname = name
        //self.date = date.stringByReplacingOccurrencesOfString("/", withString: "")
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Book(dict: dict)
    }
    override var Url:String{
        return Host.UserCommentListGet(self.coachname)
    }

}