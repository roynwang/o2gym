//
//  BodyEvalListByDate.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class BodyEvalListByDate:BodyEvalList{
    var name:String!
    var date:String!
    
    public init(name:String, date:String?){
        self.name = name
        self.date = date
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return BodyEvalItem(dict: dict)
    }
    override var Url:String{
        //return Host.AlbumGet(self.usrname).
        return Host.BodyEvalGet(self.name, date:self.date)
    }
    override var listkey:String?{
        return nil
    }

    override func buildParam()->[[String:String]]{
        var ret = [[String:String]]()
        for item in self.datalist {
            let evaldata = item as! BodyEvalItem
            var itemdata = evaldata.buildParam()
            itemdata["date"] = self.date
            itemdata["name"] = self.name
            ret.append(itemdata)
        }
        return ret
    }

}
