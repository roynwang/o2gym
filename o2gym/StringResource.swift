//
//  StringResource.swift
//  o2gym
//
//  Created by xudongbo on 7/23/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

class StringResource {
    class func PublishWeibo(count:Int)->String {
        return "发布了\(count)张新照片"
    }
    static let PublishLong:String = "发布了新秘籍"
    
    class func UpdateToastText(num:Int)->String{
        return "更新了\(num)条信息"
    }
    static let NoUpdateToastText:String = "没有更多信息了"
    
}