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
    public var delta:Int = 0

    
    var executing:Bool = false
    
    var datalist = [BaseDataItem]()
    
    var Url:String {
        preconditionFailure("This method must be overridden")
    }
    func loaditem(dict:JSON)->BaseDataItem?{
         preconditionFailure("This method must be overridden")
    }
    var listkey:String? {
        return "results"
    }
    
    public func loadHistory<T:BaseDataItem>(allcallback:(()->Void)?, itemcallback:((T)->Void)?){
        if self.nexturl == nil {
            self.delta = 0
            if allcallback != nil {
                allcallback!()
            }
            return
        }
        self.loadMore(self.nexturl!, allcallback: allcallback, itemcallback: itemcallback, listkey: "results", insert: false)
    }
    public func loadMore<T:BaseDataItem>(url:String, allcallback:(()->Void)?, itemcallback:((T)->Void)?, listkey:String?, insert:Bool){
        if self.executing {return}
        self.executing = true
        self.delta = 0
        print(url+"\n")
        request(.GET, url, headers:Local.AuthHeaders)
            .responseJSON { (_, _, data, _) in
                if data == nil {
                    if allcallback != nil{
                        allcallback!()
                    }
                    return
                }
                print(data)
                let dict = JSON(data!)
                var results:[JSON]? = nil
                if listkey == nil{
                    results = dict.arrayValue
                }else{
                    results = dict[listkey!].arrayValue
                    self.nexturl = dict["next"].string
                    self.prevurl = dict["previous"].string
                }
                if insert{
                    results?.reverse()
                }
                self.delta = results!.count
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
        self.loadMore(self.Url, allcallback: allcallback, itemcallback: itemcallback, listkey: self.listkey, insert: false)
    }
}