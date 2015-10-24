//
//  UserList.swift
//  o2gym
//
//  Created by xudongbo on 10/12/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation


public class CustomerList:BaseDataList{
    
    var coachname:String!
    
    public init(name:String){
        self.coachname = name
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return User(dict: dict)
    }
    override var Url:String{
        return Host.CustomerList(self.coachname)
    }
    override var listkey:String?{
        return nil
    }
}