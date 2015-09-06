//
//  MyProduct.swift
//  o2gym
//
//  Created by xudongbo on 9/6/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation


public class ProductList:BaseDataList{
    let coachname:String!

    
    public init(name:String){
        self.coachname = name
    }
    
    override func loaditem(dict: JSON) -> BaseDataItem {
        return Product(dict: dict)
    }
    override var Url:String{
        //return Host.AlbumGet(self.usrname).
        return Host.ProductListGet(self.coachname)
    }
    override var listkey:String?{
        return nil
    }

}
    