//
//  TrainListByDate.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
public class TrainListByDate:BaseDataList{
    
    var name:String!
    var date:String!
    var courseid:Int!
    
    public init(name:String, date:String?){
        self.name = name
        self.date = date
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Train(dict: dict)
    }
    override var Url:String{
        //return Host.AlbumGet(self.usrname).
        return Host.TrainGet(self.name, date: self.date)
    }
    override var listkey:String?{
        return nil
    }
    
    override func buildParam()->[[String:String]]{
        var ret = [[String:String]]()
        for item in self.datalist {
            let evaldata = item as! Train
            var itemdata = evaldata.buildParam()
            itemdata["date"] = self.date
            itemdata["name"] = self.name
            //courseid can be empty
            if self.courseid != nil {
                itemdata["course"] = self.courseid.toString()
            }
            ret.append(itemdata)
        }
        print(ret)
        return ret
    }
}