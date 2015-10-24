//
//  BaseDataItem.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation
import Alamofire


public class BaseDataItem:NSObject {
    
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
    public func save<T:BaseDataItem>(success_handler:((T)->Void)?, error_handler:((String)->Void)?){
        print(Local.AuthHeaders)
        request(.POST, self.UrlCreate, parameters:self.buildParam() , headers: Local.AuthHeaders)
            .validate()
            .responseJSON { (_, resp, data) in
                self.isLoaded = true
                switch data {
                case .Success(let json):
                    print(json)
                    let dict = JSON(json)
                    self.loadFromJSON(dict)
                    if success_handler != nil {
                        success_handler!(self as! T)
                    }
                    print("create success")
                case .Failure(let msg, _):
                    do {
                        let js = try NSJSONSerialization.JSONObjectWithData(msg!, options: NSJSONReadingOptions.AllowFragments)
                        if error_handler != nil {
                            let err = JSON(js)
                            if err["detail"].string != nil {
                                error_handler!(err["detail"].stringValue)
                            } else {
                                error_handler!("神奇的错误")
                            }
                        }

                    } catch {
                        if error_handler != nil {
                            error_handler!("神奇的错误")
                        }
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
                    case 200,201,202,203,204:
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
        
        req
            .validate()
            .responseJSON { (_, resp, data) in
                self.isLoaded = true
                switch data {
                case .Success(let json):
                    let dict = JSON(json)
                    self.loadFromJSON(dict)
                    if onsuccess != nil{
                        onsuccess!(self as! T)
                    }
                    
                    print("Validation Successful")
                case .Failure(_, let error):
                    
                    if onfail != nil{
                        onfail!(String(stringInterpolationSegment: resp))
                    }
                    print(error)
                }
                print(self.UrlGet)
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
            
        }
        
    }
    
    public func requestPost(url: String, parameters:[String:String], onsuccess :(()->Void)?,onfail :((String)->Void)?){
        var req:Request
        
        if self.needAuth {
            req = request(.POST, url, parameters:parameters, headers:Local.AuthHeaders)
        } else {
            req = request(.POST, url, parameters:parameters)
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

        }
        
    }
}
