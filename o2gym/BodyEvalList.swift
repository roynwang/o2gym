//
//  BodyEvalList.swift
//  o2gym
//
//  Created by xudongbo on 9/14/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class BodyEvalList:BaseDataList{

    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return BodyEvalItem(dict: dict)
    }
    override var Url:String{
        //return Host.AlbumGet(self.usrname).
        return Host.BodyEvalAllOption()
    }
    override var listkey:String?{
        return nil
    }
    
}
