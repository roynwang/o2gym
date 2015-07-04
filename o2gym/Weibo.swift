//
//  Weibo.swift
//  o2gym
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

class Weibo {
    var id: Int = 0
    var title: String = ""
    var brief: String = ""
    var imgs: String = ""
    var islong: Bool = false
    var created: String = ""
    
    var by: User? = nil
    var iscomments : Bool = false
    var commentto: Weibo? = nil
    var isfwd : Bool = false
    var fwdfrom : Weibo? = nil
    
    var upnum: Int = 0
    var commentnum: Int = 0
    var fwdnum: Int = 0
    
    var coach: User? = nil
    
    var recommand_p: Int? = nil
    
    func up(){
        self.upnum=self.upnum + 1
    }
    func down(){
        self.upnum=self.upnum - 1
    }
    func comment(content: Weibo){
        
    }
    
    func fwd(content:Weibo?){
        
    }
}

class CommentWeibo: Weibo{
    
}

class FwdWeibo: Weibo{
    
}