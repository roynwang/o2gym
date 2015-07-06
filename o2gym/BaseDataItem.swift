//
//  BaseDataItem.swift
//  o2gym
//
//  Created by xudongbo on 7/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class BaseDataItem {
    
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
    public func save(success_handler:((BaseDataItem)->Void)?, error_handler:((NSError?)->Void)?){
        request(.POST, self.UrlCreate, parameters:self.buildParam())
            .responseJSON { (_, body, data, error) in
                if error == nil{
                    let dict = JSON(data!)
                    self.loadFromJSON(dict)
                    if success_handler != nil {
                        success_handler!(self)
                    }
                } else {
                    if error_handler != nil {
                        error_handler!(error)
                    }
                }
        }

    }
    public func loadRemote(callback :((BaseDataItem)->Void)?){
        request(.GET, self.UrlGet)
            .responseJSON { (_, _, data, _) in
                let dict = JSON(data!)
                self.loadFromJSON(dict)
                if callback != nil{
                    callback!(self)
                }
        }
    }
    public func loadRemote(){
        self.loadRemote(nil)
    }
    public func loadRemote(callback: (BaseDataItem)->Void){
        self.loadRemote(callback)
    }

}
