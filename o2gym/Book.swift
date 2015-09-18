//
//  Book.swift
//  o2gym
//
//  Created by xudongbo on 8/29/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
import Alamofire
public class Book : BaseDataItem{
    var id:Int!
    public var date:String!
    public var hour:Int!
    public var coachId:Int!
    public var customerId:Int!
    public var comment:String!
    public var feedback:String! 
    public var orderId:Int!
    public var done:Bool = false
    public var rate:Int!

    
    public var coach:User!
    public var customer:User!

    
    //help variable
    public var clientdeleted:Bool = false
    public var clientadd = false
    
    
    override var UrlGet:String {
        return Host.DayBookedGet(self.coach.name!, date: self.date, hour:self.hour)
    }

    
    override var UrlCreate:String {
        return Host.DayBookedCreate(self.coach.name!, date: self.date)
    }
    
    public override init(){
        self.id = nil
    }
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    public convenience init(date:String, hour:Int, coach:User, customer:User, orderid:Int){
        self.init()
        self.coach = coach
        self.customer = customer
        self.date = date
        self.hour = hour
        self.orderId = orderid
    
    }
    
    public override func buildParam() -> [String : String] {
        return [
            "date" : self.date.stringByReplacingOccurrencesOfString("/", withString: "-"),
            "hour" : self.hour.toString(),
            "coach" : self.coach.id!.toString(),
            "custom" : self.customer.id!.toString(),
            "order"  : self.orderId.toString()
        ]
    }
    
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].int
        self.date = dict["date"].stringValue.stringByReplacingOccurrencesOfString("-", withString: "/")
        self.hour = dict["hour"].int
        self.feedback = dict["feedback"].string
        self.comment = dict["comment"].string
        self.orderId = dict["order"].int
        self.coach = User(dict: dict["coachprofile"])
        self.customer = User(dict: dict["customerprofile"])
        self.done = dict["done"].boolValue
    }
    
    public func review(){
        request(.PATCH, self.UrlGet, parameters:["order":self.orderId,"rate":self.rate, "comment":self.comment,"done":true], encoding:ParameterEncoding.JSON)
    }
    
//    public func upload(){
//        let qm:QNUploadManager = QNUploadManager()
//        //        qm.putFile(<#filePath: String!#>, key: <#String!#>, token: <#String!#>, complete: <#QNUpCompletionHandler!##(QNResponseInfo!, String!, [NSObject : AnyObject]!) -> Void#>, option: <#QNUploadOption!#>)
//        
//    }
    
}