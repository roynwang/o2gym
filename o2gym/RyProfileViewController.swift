//
//  ViewController.swift
//  nestedscroll
//
//  Created by xudongbo on 9/7/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class RYProfileViewController: UIViewController{
    
    var headerView:UIView!
    var segmentControlView:UIView!
    var viewControllerSet:[UIScrollViewDelegate]!
    
    var containerScroll:UIScrollView!
    var headerHeight:CGFloat = 220
    var segmentHeight:CGFloat = 50
    var navHeaderHeight:CGFloat!
    
    private var currentIndex:Int = 0
    
    private var curentChildView: UIScrollView!
    private var headerContainer: UIView!
    
    private var headerShown:Bool = true

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerHeight = self.headerView.frame.height
        self.segmentHeight = self.segmentControlView.frame.height
        self.navHeaderHeight = self.navigationController!.navigationBar.frame.height + UIApplication.sharedApplication().statusBarFrame.size.height
        
        
        containerScroll = UIScrollView(frame: self.view.frame)
        containerScroll.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height + headerHeight)
        containerScroll.bounces = true
        containerScroll.scrollEnabled = false
        
        self.view.addSubview(containerScroll)
        
        self.headerContainer = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.headerHeight + self.segmentHeight))
        
        //headerView.frame.size = CGSizeMake(self.view.frame.width, self.headerHeight + self.segmentHeight)
        
        self.segmentControlView.frame = CGRectMake(0, self.headerHeight, self.view.frame.width, self.segmentHeight)
        
//        self.segmentControlView.bottomBorderWidth = 3
//        self.segmentControlView.borderColor = O2Color.MainColor
//        self.segmentControlView.backgroundColor = UIColor.whiteColor()
        
        headerContainer.addSubview(headerView)
        headerContainer.addSubview(segmentControlView)
        
        containerScroll.addSubview(headerContainer)
        
        let tmp = self.viewControllerSet[0]
        let tableRect = CGRectMake(0, self.headerHeight + self.segmentHeight, self.view.frame.width, self.view.frame.height - self.segmentHeight - self.navHeaderHeight)
        if let table = tmp as? UITableViewController {
            self.curentChildView = table.tableView
        } else if let collection = tmp as? UICollectionViewController {
            self.curentChildView = collection.collectionView
        } else {
            self.curentChildView = (tmp as! UIViewController).view as! UIScrollView
        }
        self.curentChildView.frame = tableRect
        
        self.curentChildView.scrollsToTop = false

        
        self.containerScroll.addSubview(curentChildView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func switchView(toIndex:Int){
        let to:UIScrollViewDelegate = self.viewControllerSet[toIndex]
        var nextView:UIScrollView!
        if let control = to as? UITableViewController {
            nextView = (to as! UITableViewController).tableView
            
        } else if let control = to as? UICollectionViewController {
            nextView = (to as! UICollectionViewController).collectionView
            
        } else {
            nextView = (to as! UIViewController).view as! UIScrollView
        }
        //set content offset
        if nextView.contentSize.height < nextView.frame.height + self.headerHeight {
            
            nextView.contentSize = CGSize(width: self.view.frame.width, height: nextView.frame.height + self.headerHeight)
            //nextView.setContentOffset(CGPointMake(0, nextView.frame.height), animated: <#Bool#>)
            
        }
        nextView.frame = self.curentChildView.frame
        UIView.transitionWithView(self.curentChildView, duration: 0.3, options: UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
            self.curentChildView.removeFromSuperview()
            self.containerScroll.addSubview(nextView)
            }, completion: {
                (_) in
                self.currentIndex = toIndex
                self.curentChildView = nextView
        })
    }
    
}

extension RYProfileViewController:RYProfileViewDelegate  {
    func RYscrollViewDidScroll(scrollView: UIScrollView) {
        
        //curentChildView.bounces = (scrollView.contentOffset.y > 100);
        
        if self.curentChildView.contentOffset.y > 0 &&
        self.containerScroll.contentOffset.y < (self.headerHeight - self.navHeaderHeight) &&
        self.headerShown{
            
            self.containerScroll.setContentOffset(CGPointMake(0, self.headerHeight - self.navHeaderHeight),  animated: true)

            self.headerShown = false
        } else {

            
            if self.curentChildView.contentOffset.y < 0  && !self.headerShown{
                self.headerShown = true
                self.containerScroll.setContentOffset(CGPointZero, animated: true)
            }

        }
        
        print(self.containerScroll.contentOffset)
      
        
//        if self.curentChildView.contentOffset.y <= (self.headerHeight - self.navHeaderHeight) {
//            self.containerScroll.setContentOffset(self.curentChildView.contentOffset, animated: false)
//        } else {
//              self.containerScroll.setContentOffset(CGPointMake(0, self.headerHeight-self.navHeaderHeight),  animated: false)
//        }
        
    }
}





