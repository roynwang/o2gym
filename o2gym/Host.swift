//
//  Host.swift
//  o2gym
//
//  Created by xudongbo on 7/5/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

class Host {
    //static let ip : String = "http://45.33.58.236:8000/api"
    //static let ip : String = "http://127.0.0.1:8000/api"
    static let ip : String = "http://192.168.1.105:8000/api"
    static let ImgHost: String = "http://7xiwfp.com1.z0.glb.clouddn.com/"
    
    class func JwtAuth()->String{
        let url : String = "\(self.ip)/v/"
        return url
    }
    
    class func ImgUrl(key:String)->String {
        let url : String = "\(self.ImgHost)/\(key)"
        return url
    }
    class func ImgSqure(url:String, width:Int)->String {
        let url : String = "\(url)?imageView2/1/w/\(width)/h/\(width)"
        return url
    }
    
    class func UploadTokenGet()->String{
        let url : String = "\(self.ip)/p/token/"
        return url
    }
    class func WeiboGet(id: String) -> String {
        let url : String = "\(self.ip)/w/\(id)/"
        return url
    }
    class func WeiboCreate(by: String) -> String {
        let url : String = "\(self.ip)/\(by)/weibo/"
        return url
    }
    class func UserCreate() -> String{
        let url : String = "\(self.ip)/u/"
        return url
    }
    
    class func UserGet(name:String) -> String {
        let url : String = "\(self.ip)/\(name)/"
        return url
    }
    
    class func UserUp(by:String, name:String, up:Bool = true) -> String {
        var action = "up"
        if !up {
            action = "down"
        }
        let url : String = "\(self.ip)/\(by)/u/\(name)/\(action)"
        println(url)
        return url
    }
    
    class func RecommendGet()->String{
        let url : String = "\(self.ip)/r/"
        return url
    }
    
    class func FeedGet(name:String)->String{
        let url : String = "\(self.ip)/\(name)/feed/"
        return url
    }
    
    class func FeedLatest(name:String)->String{
        let url : String = "\(self.ip)/\(name)/refresh/"
        return url
    }
    
    class func CommentGet(id:Int)->String{
        let url : String = "\(self.ip)/w/\(id)/comment/"
        return url
    }
    
    class func GymGet(id:Int)->String{
        let url : String = "\(self.ip)/g/\(id)/"
        return url
    }
    class func GymCreate()->String{
        let url : String = "\(self.ip)/g/"
        return url
    }
    
    class func MyPostGet(name:String)->String{
        let url : String = "\(self.ip)/\(name)/weibo/"
        return url
    }
    
    class func MyCourseGet(name:String)->String{
        let url : String = "\(self.ip)/\(name)/courses/"
        return url
    }
    
    class func AlbumGet(name:String)->String{
        let url : String = "\(self.ip)/\(name)/album/"
        return url
    }
    
    class func CourseGet(id:Int)->String{
        let url : String = "\(self.ip)/c/\(id)/"
        return url
    }

    class func CourseCreate()->String{
        let url : String = "\(self.ip)/c/"
        return url
    }
    class func TimelineGet(name:String)->String{
        let url : String = "\(self.ip)/\(name)/timeline"
        return url
    }
    
    class func WeiboUp(weibo:Weibo, up:Bool = true) ->String{
        var action = "up"
        if !up {
            action = "down"
        }
        let url : String = "\(self.ip)/\(Local.USER.name!)/w/\(weibo.id!.toString())/\(action)"
        println(url)
        return url
    }
    
    class func ArticleGet(id:Int) -> String{
        let url : String = "\(self.ip)/l/\(id)/"
        return url
    }
    
    class func Follow(user:String, follows:String) -> String{
        let url : String = "\(self.ip)/\(user)/follow/?target=\(follows)"
        return url
    }
    class func DayBookedGet(user:String, date:String) -> String{
        let url : String = "\(self.ip)/\(user)/b/\(date)/"
        return url
    }
    class func DayBookedCreate(user:String, date:String) -> String{
        let fdate = date.stringByReplacingOccurrencesOfString("/", withString: "")
        let url : String = "\(self.ip)/\(user)/b/\(fdate)/"
        return url
    }
    class func DayBookedGet(user:String, date:String, hour:Int) -> String{
        let fdate = date.stringByReplacingOccurrencesOfString("/", withString: "")
        let url : String = "\(self.ip)/\(user)/b/\(fdate)/\(hour)/"
        return url
    }
    class func WeekBookedGet(user:String, date:String) -> String{
        let fdate = date.stringByReplacingOccurrencesOfString("/", withString: "")
        let url : String = "\(self.ip)/\(user)/w/\(fdate)/"
        return url
    }
    class func DayTimeGet(user:String, date:String) -> String{
        let fdate = date.stringByReplacingOccurrencesOfString("/", withString: "")
        let url : String = "\(self.ip)/\(user)/d/\(fdate)/"
        return url
    }
    class func RestTime(user:String)->String{
        let url : String = "\(self.ip)/\(user)/rest/"
        return url
    }
    class func OrderItemGet(user:String,billid:Int)->String{
        let url : String = "\(self.ip)/\(user)/b/\(billid)/"
        return url
    }
    class func OrderItemGet(user:String,id:Int)->String{
        let url : String = "\(self.ip)/\(user)/o/\(id)/"
        return url
    }
    
    class func OrderItemCreate(user:String)->String{
        let url : String = "\(self.ip)/\(user)/o/"
        return url
    }
    
    class func OrderListGet(user:String)->String{
        let url : String = "\(self.ip)/\(user)/o/"
        return url
    }
    class func ProductGet(id:Int)->String {
        let url : String = "\(self.ip)/p/\(id)/"
        return url
    }
    
    class func ProductCreate(user:String)->String {
        let url : String = "\(self.ip)/\(user)/p/"
        return url
    }
    
    class func BookCreate(user:String, date:String) -> String{
        let fdate = date.stringByReplacingOccurrencesOfString("/", withString: "")
        let url : String = "\(self.ip)/\(user)/b/"
        return url
    }
    
    class func ProductListGet(user:String) -> String {
        let url : String = "\(self.ip)/\(user)/p/"
        return url
    }
    
    class func PayOrderGet(orderid:Int,channel:String) -> String {
        let url : String = "\(self.ip)/pay/\(orderid)/\(channel)/"
        return url
    }
    
    class func BodyEvalAllOption() -> String{
        return "\(self.ip)/e/"
    }
    
    class func BodyEvalGet(name:String, date:String?) -> String{
        if date != nil {
            return "\(self.ip)/\(name)/e/\(date!)/"
        }
        return "\(self.ip)/\(name)/e/"
    }
    
    //class func TrainGet(name:String, date:String)
    class func TrainGet(name:String, date:String?) -> String{
        if date != nil {
            return "\(self.ip)/\(name)/t/\(date!)/"
        }
        return "\(self.ip)/\(name)/t/"
    }
}
