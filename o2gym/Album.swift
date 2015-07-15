//
//  Album.swift
//  o2gym
//
//  Created by xudongbo on 7/15/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Album:BaseDataList {
    
    let usrname:String!
    
    public init(name:String){
        self.usrname = name
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Pic(dict: dict)
    }
    override var Url:String{
        return Host.AlbumGet(self.usrname)
    }
}
