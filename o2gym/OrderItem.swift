//
//  BillItem.swift
//  o2gym
//
//  Created by xudongbo on 9/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
import Alamofire


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
    public var amount:Int!
  
    override var UrlCreate:String {
        return Host.OrderItemCreate(self.name!)
    }
    
    override var UrlGet:String {
        if self.id == nil {
            return Host.OrderItemGet(self.name!,billid:self.billid)
        }
        return Host.OrderItemGet(self.name!, id: self.id)
    }
    
    public convenience init(product:Product, customer:User) {
        self.init()
        
        self.product = product.id
        self.coach = product.coach
        self.customer = customer
        self.status = "unpaid"
        self.name = self.customer.name
    }
    public convenience init(name:String,billid:Int){
        self.init()
        self.name = name
        self.billid = billid
    }
    public convenience init(name:String,orderid:Int){
        self.init()
        self.name = name
        self.id = orderid
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
        self.amount = dict["amount"].intValue
        //TODO
        self.name = self.customer.name
        
    }
    
    public override func buildParam() -> [String : String] {
        let ret =  [
            "coach": self.coach.id!.toString(),
            "custom": self.customer.id!.toString(),
            "product": self.product.toString()
        ]

        print(ret)
        return ret
    }
    
    public func pay(on_success:(()->Void)?){
        
        //get the charge
       Alamofire.request(.GET, Host.PayOrderGet(self.billid,channel: "wx"))
        .responseString(encoding: NSUTF8StringEncoding) {
            (_, resp, data) -> Void
            in
            if resp?.statusCode == 201 {
                Pingpp.createPayment(data.value, appURLScheme: "o2gym", withCompletion: {
                    (result, error) -> Void
                    in
                    print(result)
                    if error != nil {
                        print(error.code.rawValue)
                        print(error.getMsg())
                    } else {
                        on_success!()
                    }

                })
            } else {
                print(data.error)
            }
        }
        
        
        
//        request(.PATCH, self.UrlGet, parameters:["status":"paid"])
//            .responseJSON { (_, resp, data, error) in
//                println(resp)
//                if on_success != nil {
//                    on_success!()
//                }
//
//            }
    }
    
}