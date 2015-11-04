//
//  Income.swift
//  o2gym
//
//  Created by xudongbo on 11/3/15.
//  Copyright © 2015 royn. All rights reserved.
//

import Foundation


public class Income : BaseDataItem{
    public var name:String!
    public var completed_course_price:Int!
    public var sold_price:Int!
    public var completed_course:Int!
    
    
    
    public convenience init(name:String){
        self.init()
        self.name = name
    }
    
    public override func loadFromJSON(dict: JSON) {
       self.completed_course_price = dict["completed_course_price"].int
       self.sold_price = dict["sold_price"].int
       self.completed_course = dict["completed_course"].int
    }
    
    override var UrlGet:String {
        return Host.IncomeGet(self.name)
    }

}