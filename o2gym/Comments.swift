//
//  Comments.swift
//  o2gym
//
//  Created by xudongbo on 7/9/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Comments : BaseDataList{

    let weiboid:Int?
    
    public init(id:Int){
        self.weiboid = id
        
    }
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Weibo(dict: dict)
    }
    override var Url:String{
        return Host.CommentGet(self.weiboid!)
    }
}