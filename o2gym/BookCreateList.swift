//
//  BookCreateList.swift
//  o2gym
//
//  Created by xudongbo on 9/5/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class BookCreateList:BaseDataList{
    let coachname:String!
    var date:String!
    

    public init(name:String, date:String){
        self.coachname = name
        //self.date = date.stringByReplacingOccurrencesOfString("/", withString: "")
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Book(dict: dict)
    }
    override var Url:String{
        //return Host.AlbumGet(self.usrname).
        return Host.BookCreate(self.coachname, date:self.date)
    }
    override var listkey:String?{
        return nil
    }
    override func buildParam() -> [[String : String]] {
        var ret:[[String:String]] = [[String:String]]()
        for d in self.datalist {
            let book = d as! Book
            ret.append(book.buildParam())
        }
        return ret
    }
}