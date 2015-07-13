//
//  Weibo.swift
//  o2gym
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class Weibo : BaseDataItem {

    let usr:User
    
    var id: Int? = 0
    public var title: String = ""
    public var brief: String = ""
    var imgs: String = ""
    var islong: Bool = false
    var created: String = ""
    
    var by: Int = 0
    var iscomments : Bool = false
    var commentto: Int? = nil
    var isfwd : Bool = false
    var fwdfrom : Int? = nil
    
    var upnum: Int = 0
    var commentnum: Int = 0
    var fwdnum: Int = 0
    
    var coach: Int? = nil
    
    var recommend_p: Int? = nil
    
    var author: Dictionary<String,JSON>? = nil
    
    var topcomments: Array<JSON>? = []
    
    var img_set:[String] = []
    
    func load_img_set(){
        if let dataFromString = self.imgs.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            for item in json.arrayValue {
                self.img_set.append(item.stringValue)
            }
        }
    }
    
    override var type:String {
        return "weibo"
    }

    override var UrlCreate:String {
        return Host.WeiboCreate(self.usr.name!)
    }
    
    override var UrlGet:String {
        return Host.WeiboGet(self.id!.toString())
    }
    
    public init(usr: User, weiboid: Int?) {
        self.usr = usr
        self.id = weiboid
    }
    public convenience init(dict:JSON){
        self.init(usr: User(name: dict["by"].stringValue), weiboid: dict["id"].intValue)
        self.loadFromJSON(dict)
    }
    public convenience init(usr: User){
        self.init(usr:usr,weiboid:nil)
    }
    
    public func setContent(title:String, brief:String, imgs:String){
        self.title = title
        self.brief = brief
        self.imgs = imgs
        self.load_img_set()
    }
    
    public override func buildParam()->[String:String]{
        var params = [
            "title": self.title,
            "brief": self.brief,
            "imgs": self.imgs,
            "by": self.usr.id!.toString()
        ]
        //可选参数
        if self.iscomments {
            params["iscomments"] = "true"
            params["commentto"] = self.commentto?.toString()
        }
        if self.isfwd {
            params["isfwd"] = "true"
            params["fwdfrom"] = self.fwdfrom?.toString()
        }
        if self.coach != nil {
            params["coach"] = self.coach?.toString()
        }
        return params
    }
    
    public override func loadFromJSON(dict:JSON){
        self.id = dict["id"].intValue
        self.title = dict["title"].stringValue
        self.brief = dict["brief"].stringValue
        self.imgs = dict["imgs"].stringValue
        self.islong = dict["islong"].boolValue
        self.created = dict["created"].stringValue
        
        self.by = dict["by"].intValue
        self.iscomments = dict["iscomments"].boolValue
        self.commentto = dict["commentto"].intValue
        self.isfwd = dict["isfwd"].boolValue
        self.fwdfrom = dict["fwdfrom"].intValue
        
        self.upnum = dict["upnum"].intValue
        self.commentnum = dict["upnum"].intValue
        self.fwdnum = dict["upnum"].intValue
        
        self.coach = dict["coach"].int
        self.recommend_p = dict["recommend_p"].int
        
        self.author = dict["author"].dictionaryValue
        self.topcomments = dict["topcomments"].arrayValue
        
        self.load_img_set()
    }
    
    public func up(){
        self.upnum=self.upnum + 1
    }
    public func down(){
        self.upnum=self.upnum - 1
    }
    public func comment(content: Weibo){
        
    }
    
    public func fwd(content:Weibo?){
    }
}

public class WeiboBrief:Weibo {
    public init(usr:User, dict:JSON){
        super.init(usr: usr, weiboid: dict["id"].int)
        self.loadbrief(dict)
        
    }
    func loadbrief(dict:JSON){
    }

}