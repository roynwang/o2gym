//
//  Pic.swift
//  o2gym
//
//  Created by xudongbo on 7/15/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class Pic : BaseDataItem{
    var id:Int!
    public var url:String!
    var by:Int!
    

    override var type:String {
        return "pic"
    }
    
    public override init(){
        self.id = nil
        self.url = nil
    }
    
    public convenience init(url:String){
        self.init()
        self.id = nil
        self.url = url
    }
    
    public convenience init(dict:JSON){
        self.init()
        self.loadFromJSON(dict)
    }
    
    override var UrlGet:String {
        return Host.PicGet(self.by, id: self.id)
    }
    
    public override func loadFromJSON(dict: JSON) {
        self.id = dict["id"].int
        self.url = dict["url"].string
        self.by = dict["by"].int
    }
    
//    public func upload(){
//        let qm:QNUploadManager = QNUploadManager()
////        qm.putFile(<#filePath: String!#>, key: <#String!#>, token: <#String!#>, complete: <#QNUpCompletionHandler!##(QNResponseInfo!, String!, [NSObject : AnyObject]!) -> Void#>, option: <#QNUploadOption!#>)
//
//    }

}