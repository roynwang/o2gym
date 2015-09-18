//
//  BaseDataItem.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
import Alamofire


public class BaseDataItem {
    
    var type:String {
        return "base"
    }
    
    var needAuth:Bool{
        return false
    }
    
    var isLoaded:Bool = false
    
    public convenience init(dict:JSON){
        preconditionFailure("This method must be overridden")
    }
    
    //创建的url
    var UrlCreate:String {
        preconditionFailure("This method must be overridden")
    }
    //查询
    var UrlGet:String{
        preconditionFailure("This method must be overridden")
    }
    
    //json转obj
    func loadFromJSON(dict:JSON) {
        preconditionFailure("This method must be overridden")
    }
    //create 参数列表
    func buildParam()->[String:String]{
        preconditionFailure("This method must be overridden")
    }
    public func save<T:BaseDataItem>(success_handler:((T)->Void)?, error_handler:((NSError?)->Void)?){
        request(.POST, self.UrlCreate, parameters:self.buildParam())
            .responseJSON { (_, resp, data) in
                print(resp?.statusCode)

            
                if resp?.statusCode == 201{
                    let dict = JSON(data.value!)
                    self.loadFromJSON(dict)
                    if success_handler != nil {
                        success_handler!(self as! T)
                    }
                } else {
                    if error_handler != nil {
                        //error_handler!(error)
                    }
                }
        }
    }
    public func update<T:BaseDataItem>(onsuccess:((T)->Void)?, onfail:((String?)->Void)?){
        request(.PATCH, self.UrlGet, parameters:self.buildParam(), encoding:ParameterEncoding.JSON)
            .response{ (_, resp, data, error) in
                if error == nil{
                    switch resp!.statusCode{
                    case 200,201,202,203:
                        if onsuccess != nil{
                            onsuccess!(self as! T)
                        }
                        break
                    case 404:
                        if onfail != nil{
                            onfail!("无法访问" + self.UrlGet)
                        }
                        break
                    default:
                        print(resp?.description)
                        if onfail != nil{
                            onfail!(String(stringInterpolationSegment: resp))
                        }
                    }
                } else{
                    if onfail != nil{
                        //onfail!(error!.description)
                    } else {
                        //print(error!.description)
                    }
                }
        }
    }
    
    
    public func delete<T:BaseDataItem>(onsuccess:((T)->Void)?, onfail:((String?)->Void)?){

        
        request(.DELETE, self.UrlGet, headers:Local.AuthHeaders)
            .response{ (_, resp, data, error) in
                if error == nil{
                    switch resp!.statusCode{
                    case 200,201,202,203:
                        if onsuccess != nil{
                            onsuccess!(self as! T)
                        }
                        break
                    case 404:
                        if onfail != nil{
                            onfail!("无法访问" + self.UrlGet)
                        }
                        break
                    default:
                        print(resp?.description)
                        if onfail != nil{
                            onfail!(String(stringInterpolationSegment: resp))
                        }
                    }
                } else{
                    if onfail != nil{
                        //onfail!(error!.description)
                    } else {
                        //print(error!.description)
                    }
                }
        }
    }
    
    

    
    
    
    public func loadRemote<T:BaseDataItem>(onsuccess :((T)->Void)?,onfail :((String)->Void)?){
        var req:Request
        
        if self.needAuth {
            req = request(.GET, self.UrlGet,headers:Local.AuthHeaders)
        } else {
            req = request(.GET, self.UrlGet)
        }
        
        req.responseJSON { (_, resp, data) in
                print(self.UrlGet)
                //if error == nil{
                    self.isLoaded = true
                    switch resp!.statusCode{
                    case 200:
                        let dict = JSON(data.value!)
                        self.loadFromJSON(dict)
                        if onsuccess != nil{
                            onsuccess!(self as! T)
                        }
                        break
                    case 404:
                        if onfail != nil{
                            onfail!("无法访问" + self.UrlGet)
                        }
                        break
                    default:
                        if onfail != nil{
                            onfail!(String(stringInterpolationSegment: resp))
                        }
                    }
//                } else{
//                    if onfail != nil{
//                        onfail!(error!.description)
//                    } else {
//                        print(error!.description)
//                    }
//                }
        }
    }
    public func loadRemote(){
        self.loadRemote(nil, onfail: nil)
    }
    
    public func requestGet(url: String,onsuccess :(()->Void)?,onfail :((String)->Void)?){
        var req:Request
        
        if self.needAuth {
            req = request(.GET, url,headers:Local.AuthHeaders)
        } else {
            req = request(.GET, url)
        }
 
        req.responseJSON { (_, resp, data) in
//                if error == nil{
                    switch resp!.statusCode{
                    case 200,201,202,203:
                        if onsuccess != nil{
                            onsuccess!()
                        }
                        break
                    case 404:
                        if onfail != nil{
                            onfail!("无法访问" + url)
                        }
                        break
                    default:
                        if onfail != nil{
                            onfail!(String(stringInterpolationSegment: resp))
                        }
                    }
//                } else{
//                    if onfail != nil{
//                        onfail!(error!.description)
//                    }
//                }
        }
        
    }
}
