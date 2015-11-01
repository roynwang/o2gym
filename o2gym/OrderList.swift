//
//  OrderList.swift
//  o2gym
//
//  Created by xudongbo on 9/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
public class OrderList:BaseDataList {
    let name:String!
    
    var coach:String!
    
    public init(name:String){
        self.name = name
    }
    
    public init(name:String, coach:String) {
        self.name = name
        self.coach = coach
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return OrderItem(dict: dict)
    }
    override var Url:String{
        return Host.OrderListGet(self.name, coach:self.coach)
    }
//    override var listkey:String?{
//        return nil
//    }
}