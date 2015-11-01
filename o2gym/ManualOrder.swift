//
//  ManualOrder.swift
//  o2gym
//
//  Created by xudongbo on 10/26/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation


public class ManualOrder : BaseDataItem{
    public var id:Int!
    public var coach:User!
    public var customer_phone:String!
    public var customer_displayname:String!
    public var product_price:String!
    public var product_introduction:String!
    public var product_amount:String!
   
    
    public var order:OrderItem!
    
    
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    override init(){
        super.init()
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.order = OrderItem(dict: dict)
    }
    
    public override func buildParam() -> [String : String] {
        return [
            "customer_phone": self.customer_phone,
            "customer_displayname":self.customer_displayname,
            "product_introduction": self.product_introduction,
            "product_price":self.product_price,
            "product_amount":self.product_amount,
            "product_promotion":self.product_price,
        ]
    }
    public override var UrlCreate:String{
        return Host.ManualOrderCreate(self.coach.name!)
    }

}