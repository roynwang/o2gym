//
//  BaseDataList.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
import Alamofire

public class BaseDataList {
    
    
    public var count:Int {
        get {
            return self.datalist.count
        }
    }
    public var nexturl:String? = nil
    public var prevurl:String? = nil
    public var delta:Int = 0
    public var isLoaded:Bool = false

    var needAuth:Bool{
        return false
    }
    
    
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
    
    func buildParam()->[[String:String]]{
        preconditionFailure("This method must be overridden")
    }
    
    public func bulkCreate(success_handler:(()->Void)?, error_handler:((NSError?)->Void)?){
        
        let trequest = NSMutableURLRequest(URL: NSURL(string: self.Url)!)
        trequest.HTTPMethod = "POST"
        trequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if self.needAuth {
            for (key,value) in Local.AuthHeaders{
             trequest.setValue(key, forHTTPHeaderField: value)
            }
        }
        
    let values = self.buildParam()
        
       var error: NSError!
        do {
            trequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(values, options: [])
        } catch let error1 as NSError {
            error = error1
            trequest.HTTPBody = nil
        }
        
        request(trequest as URLRequestConvertible)
            .responseJSON {
                (_, resp, data) in
                print(resp)
                print(data)
                if resp?.statusCode == 201{
                    if success_handler != nil {
                        success_handler!()
                    }
                } else {
                    if error_handler != nil {
                        //error_handler!(error)
                    }
                }
                
                
        }
        
//        request(.POST, self.Url, parameters: self.buildParam(), encoding: ParameterEncoding.JSON, headers: Local.AuthHeaders)
        
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
        var req:Request
        if self.needAuth {
            req = request(.GET, url, headers:Local.AuthHeaders)
        } else {
            req = request(.GET, url)
        }
        req.responseJSON { (_, _, data) in
                if data.value == nil {
                    if allcallback != nil{
                        allcallback!()
                    }
                    return
                }
                print(data, terminator: "")
                let dict = JSON(data.value!)
                var results:[JSON]? = nil
                if listkey == nil{
                    results = dict.arrayValue
                }else{
                    results = dict[listkey!].arrayValue
                    self.nexturl = dict["next"].string
                    self.prevurl = dict["previous"].string
                }
                if insert{
                    Array(arrayLiteral: results?.reverse())
                }
                self.delta = results!.count
                for item in results! {
                    let tmp = self.loaditem(item)!
                    if !insert{
                        self.datalist.append(tmp)
                    } else{
                        self.datalist.insert(tmp, atIndex: 0)
                    }
                    //self.count += 1
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
        self.isLoaded = true
        self.datalist = []
        self.loadMore(self.Url, allcallback: allcallback, itemcallback: itemcallback, listkey: self.listkey, insert: false)
    }
    
//    public func requestPost(url: String, parameters:[String:String], onsuccess :(()->Void)?,onfail :((String)->Void)?){
//        var req:Request
//        
//        if self.needAuth {
//            req = request(.POST, url, parameters:parameters, headers:Local.AuthHeaders)
//        } else {
//            req = request(.POST, url, parameters:parameters)
//        }
//        
//        req.responseJSON { (_, resp, data) in
//            //                if error == nil{
//            switch resp!.statusCode{
//            case 200,201,202,203:
//                if onsuccess != nil{
//                    onsuccess!()
//                }
//                break
//            case 404:
//                if onfail != nil{
//                    onfail!("无法访问" + url)
//                }
//                break
//            default:
//                if onfail != nil{
//                    onfail!(String(stringInterpolationSegment: resp))
//                }
//            }
//            
//        }
//        
//    }

}