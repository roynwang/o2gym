//
//  o2gymTests.swift
//  o2gymTests
//
//  Created by xudongbo on 7/4/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit
import XCTest
import o2gym


public class o2gymTests: XCTestCase {
    
    override public func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override public func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testUserCreate(){
        var usr = User(id:nil, name:"royn",iscoach:true)
        usr.save(nil, error_handler: nil)
        sleep(1)
    }
    
    func testUserGet(){
        var usr = User(name:"royn")
        usr.loadRemote()
        sleep(1)
    }
    
    func testWeiboCreate(){
        let usr = User(id:2,name:"royn")
        let weibo = Weibo(usr:usr)
        weibo.setContent("mmmmmmm", brief: "brief", imgs: "imgs")
        weibo.save(nil,error_handler: nil)
        sleep(1)
    }
    
    func testWeiboGet(){
        let usr = User(id:2,name:"royn")
        let weibo = Weibo(usr:usr, weiboid:4)
        weibo.loadRemote()
        sleep(1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
