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
    
    private var containerScroll:UIScrollView!
    private var headerHeight:CGFloat = 200
    private var segmentHeight:CGFloat = 50
    private var currentIndex:Int = 0
    
    private var curentChildView: UIScrollView!
    private var headerContainer: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerHeight = self.headerView.frame.height
        self.segmentHeight = self.segmentControlView.frame.height
        
        
        containerScroll = UIScrollView(frame: self.view.frame)
        containerScroll.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height + headerHeight)
        containerScroll.bounces = false
        containerScroll.scrollEnabled = false
        
        self.view.addSubview(containerScroll)
        
        self.headerContainer = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.headerHeight + self.segmentHeight))
        
        //headerView.frame.size = CGSizeMake(self.view.frame.width, self.headerHeight + self.segmentHeight)
        
        self.segmentControlView.frame = CGRectMake(0, self.headerHeight, self.view.frame.width, self.segmentHeight)
        
        headerContainer.addSubview(headerView)
        headerContainer.addSubview(segmentControlView)
        
        containerScroll.addSubview(headerContainer)
        
        let tmp = self.viewControllerSet[1]
        let tableRect = CGRectMake(0, self.headerHeight + self.segmentHeight, self.view.frame.width, self.view.frame.height - self.segmentHeight)
        if let table = tmp as? UITableViewController {
            self.curentChildView = table.tableView
        } else if let collection = tmp as? UICollectionViewController {
            self.curentChildView = collection.collectionView
        } else {
            self.curentChildView = (tmp as! UIViewController).view as! UIScrollView
        }
        self.curentChildView.frame = tableRect
        
        self.curentChildView.delegate = self
        self.curentChildView.scrollsToTop = false
        self.curentChildView.bounces = false
        
        self.containerScroll.addSubview(curentChildView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func switchView(toIndex:Int){
        let to:UIScrollViewDelegate = self.viewControllerSet[toIndex]
        var nextView:UIScrollView!
        if to.isMemberOfClass(UITableViewController) {
            nextView = (to as! UITableViewController).tableView
            nextView.frame = self.curentChildView.frame
        }
        UIView.transitionWithView(self.curentChildView, duration: 0.3, options: UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
            self.curentChildView.removeFromSuperview()
            self.containerScroll.addSubview(nextView)
            }, completion: {
                (_) in
                self.curentChildView = nextView
                self.curentChildView.scrollEnabled = false
                nextView.delegate = self
                self.currentIndex = toIndex
        })
    }
    
}

extension RYProfileViewController:UIScrollViewDelegate  {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.curentChildView.contentOffset.y < self.headerHeight {
            self.containerScroll.setContentOffset(self.curentChildView.contentOffset, animated: false)
        }
        
        if self.viewControllerSet[self.currentIndex].scrollViewDidScroll != nil {
            self.viewControllerSet[self.currentIndex].scrollViewDidScroll!(self.curentChildView)
        }
        
    }
}




