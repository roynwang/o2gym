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
    
    public init(name:String){
        self.name = name
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return OrderItem(dict: dict)
    }
    override var Url:String{
        return Host.OrderListGet(self.name)
    }
//    override var listkey:String?{
//        return nil
//    }
}