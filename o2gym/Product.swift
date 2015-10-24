//
//  Product.swift
//  o2gym
//
//  Created by xudongbo on 9/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Product : BaseDataItem{
    public var id:Int!
    public var pic:String!
    public var introduction:String!
    public var amount:Int!
    public var price:Int!
    public var promotion:Int!
    public var coach:User!
    public var soldcount:Int!


    
    
    override var UrlGet:String {
        return Host.ProductGet(self.id!)
    }
    override var UrlCreate:String {
        return Host.ProductCreate(self.coach.name!)
    }
    
    public convenience init(productid:Int){
        self.init()
        self.id = productid
    }
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    public convenience init(coach:User){
        self.init()
        self.coach = coach
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].intValue
        self.pic = dict["pic"].string
        self.introduction = dict["introduction"].string
        self.amount = dict["amount"].int
        self.price = dict["price"].int
        self.promotion = dict["promotion"].int
        self.coach = User(dict: dict["coachdetail"])
        self.soldcount = dict["soldcount"].intValue
        
    }
    public override func buildParam() -> [String : String] {
        return [
            "coach":self.coach.id!.toString(),
            "amount":self.amount.toString(),
            "price":self.price.toString(),
            "promotion":self.promotion.toString(),
            "introduction":self.introduction
        ]
    }
    
}