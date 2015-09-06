//
//  BillItem.swift
//  o2gym
//
//  Created by xudongbo on 9/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class OrderItem : BaseDataItem{
    public var id:Int!
    public var name:String!
    public var billid:Int!
    public var created:String!
    public var paidtime:String!
    public var status:String!
    public var customer:User!
    public var coach:User!
    public var product:Int!
    public var booked:[Book] = []
    
  
    
    override var UrlGet:String {
        return Host.OrderItemGet(self.name!,billid:self.billid)
    }
    public convenience init(name:String,billid:Int){
        self.init()
        self.name = name
        self.billid = billid
    }
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)

    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].intValue
        self.billid = dict["billid"].intValue
        self.created = dict["created"].stringValue
        self.paidtime = dict["paidtime"].string
        self.status = dict["status"].stringValue
        self.customer = User(dict: dict["customerdetail"])
        self.coach = User(dict: dict["coachdetail"])
        self.product = dict["product"].int
        self.booked = []
        if nil != dict["booked"] {
            for book in dict["booked"].arrayValue {
                self.booked.append(Book(dict: book))
            }
        }
    }
    
}