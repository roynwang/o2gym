//
//  Feed.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class Feed:BaseDataList {
    
    let usr:User = Local.USER
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Weibo(dict: dict)
    }
    override var Url:String{
        return Host.FeedGet(self.usr.name!)
    }
    public func loadLatest(onsuccess:(()->Void)?, onfail: ((String)->Void)?){
        let url = Host.FeedLatest(self.usr.name!)
        self.loadMore(url, allcallback: onsuccess, itemcallback: nil, listkey: nil, insert:true)
    }
}
