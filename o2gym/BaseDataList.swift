//
//  BaseDataList.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

public class BaseDataList {
    public var count:Int = 0
    public var nexturl:String? = nil
    public var prevurl:String? = nil
    
    var executing:Bool = false
    
    var datalist = [BaseDataItem]()
    
    var Url:String {
        preconditionFailure("This method must be overridden")
    }
    func loaditem(dict:JSON)->BaseDataItem?{
         preconditionFailure("This method must be overridden")
    }
    
    public func loadHistory<T:BaseDataItem>(allcallback:(()->Void)?, itemcallback:((T)->Void)?){
        if self.nexturl == nil {
            return
        }
        self.loadMore(self.nexturl!, allcallback: allcallback, itemcallback: itemcallback, listkey: "results", insert: false)
    }
    public func loadMore<T:BaseDataItem>(url:String, allcallback:(()->Void)?, itemcallback:((T)->Void)?, listkey:String?, insert:Bool){
        if self.executing {return}
        self.executing = true
        print(url+"\n")
        request(.GET, url)
            .responseJSON { (_, _, data, _) in
                print(data)
                let dict = JSON(data!)
                var results:[JSON]? = nil
                self.nexturl = dict["next"].string
                self.prevurl = dict["previous"].string
                if listkey == nil{
                    results = dict.arrayValue
                }else{
                    results = dict[listkey!].arrayValue
                }
                if insert{
                    results?.reverse()
                }
                for item in results! {
                    let tmp = self.loaditem(item)!
                    if !insert{
                        self.datalist.append(tmp)
                    } else{
                        self.datalist.insert(tmp, atIndex: 0)
                    }
                    self.count += 1
                    if itemcallback != nil{
                        itemcallback!(tmp as! T)
                    }
                }
                if allcallback != nil{
                    allcallback!()
                }
               self.executing = false
                
        }
    }
    
    public func load<T:BaseDataItem>(allcallback:(()->Void)?, itemcallback:((T)->Void)?){
        self.loadMore(self.Url, allcallback: allcallback, itemcallback: itemcallback, listkey: "results", insert: false)
    }
}