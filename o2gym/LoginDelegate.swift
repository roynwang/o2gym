//
//  LoginDelegate.swift
//  o2gym
//
//  Created by xudongbo on 9/18/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import Foundation

protocol LoginDelegate {
    func sendSms()
    func loginWithWeChat()
    func loginWithVcode()
}
