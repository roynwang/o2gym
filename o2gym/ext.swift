//
//  ext.swift
//  o2gym
//
//  Created by xudongbo on 7/5/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

extension Bool {
    func toString()->String{
        if self{
            return "true"
        }
        return "false"
    }
}

extension Int {
    func toString() ->String {
        return String(self)
    }
}