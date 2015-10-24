//
//  WorkingTimeConfigViewController.swift
//  o2gym
//
//  Created by xudongbo on 9/1/15.
//  Copyright (c) 2015 royn. All rights reserved.
//

import UIKit

class WorkingTimeConfigViewController: UIViewController {
    var restTime:RestTime!
    
    @IBOutlet weak var ExceptionLeaveTable: UITableView!
    @IBOutlet weak var ExceptionWorkingTable: UITableView!
    @IBOutlet weak var RestDaysText: UILabel!
    @IBOutlet weak var RestDay: UICollectionView!
    
    
    var curTable:UITableView!
    //obsolete
    @IBAction func addExceptionalWorking(sender: AnyObject) {
        self.curTable = self.ExceptionWorkingTable
        self.showDatePicker()
    }
    //obsolete
    @IBAction func addExceptionalLeave(sender: AnyObject) {
        self.curTable = self.ExceptionLeaveTable
        self.showDatePicker()
    }
    
    lazy var datePicker:THDatePickerViewController = {
        var dp = THDatePickerViewController.datePicker()
        dp.delegate = self
        dp.setAllowClearDate(false)
        dp.setClearAsToday(true)
        dp.setAutoCloseOnSelectDate(false)
        dp.setAllowSelectionOfSelectedDate(true)
        dp.setDisableHistorySelection(true)
        dp.setDisableFutureSelection(false)
        //dp.autoCloseCancelDelay = 5.0
        dp.selectedBackgroundColor = O2Color.LightMainColor
        dp.currentDateColor = UIColor(red: 242/255.0, green: 121/255.0, blue: 53/255.0, alpha: 1.0)
        dp.currentDateColorSelected = UIColor.whiteColor()
        return dp
        }()
    
    
    func showDatePicker(){
        
        datePicker.date = NSDate()
        
        
//        presentSemiViewController(datePicker, withOptions: [
//            KNSemiModalOptionKeys.pushParentBack    : NSNumber(bool: false),
//            KNSemiModalOptionKeys.animationDuration : NSNumber(float: 0.3),
//            KNSemiModalOptionKeys.shadowOpacity     : NSNumber(float: 0.3)
//            ])
        presentSemiViewController(datePicker)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restTime = RestTime(name:Local.USER.name!)
        
        self.RestDay.dataSource = self
        self.RestDay.delegate = self
        
        self.RestDay.registerNib(UINib(nibName: "TimeTableCell", bundle: nil), forCellWithReuseIdentifier: "timetablecell")
        
        self.ExceptionLeaveTable.registerNib(UINib(nibName: "PlainTextCell", bundle: nil), forCellReuseIdentifier: "leave")
        self.ExceptionWorkingTable.registerNib(UINib(nibName: "PlainTextCell", bundle:nil), forCellReuseIdentifier: "work")
        
        self.ExceptionWorkingTable.registerNib(UINib(nibName: "WorkingTimeSectionHeader", bundle: nil), forCellReuseIdentifier: "header")
        self.ExceptionLeaveTable.registerNib(UINib(nibName: "WorkingTimeSectionHeader", bundle:nil), forCellReuseIdentifier: "header")
        

        self.ExceptionLeaveTable.dataSource = self
        self.ExceptionLeaveTable.delegate = self
        self.ExceptionWorkingTable.dataSource = self
        self.ExceptionWorkingTable.delegate = self
        self.ExceptionLeaveTable.bounces = false
        self.ExceptionWorkingTable.bounces = false
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let b = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Done, target: self, action: "save")
        
        
        self.navigationItem.rightBarButtonItem = b
        
        self.hidesBottomBarWhenPushed = true

        
        // Do any additional setup after loading the view.
    }
    func save(){
        self.restTime.update({ (_) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }, onfail: { (_) -> Void in
            print("failed")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        self.restTime.loadRemote({ (_) -> Void in
            self.ExceptionLeaveTable.reloadData()
            self.ExceptionWorkingTable.reloadData()
            self.RestDay.reloadData()
            }, onfail: nil)
    }
    
}
extension WorkingTimeConfigViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("timetablecell", forIndexPath: indexPath) as! TimeTableCell
        //cell.frame.size = CGSize(width: 50, height: 30)
        switch indexPath.row {
        case 0:
            cell.Time.text = "周日"
        case 1:
            cell.Time.text = "周一"
        case 2:
            cell.Time.text = "周二"
        case 3:
            cell.Time.text = "周三"
        case 4:
            cell.Time.text = "周四"
        case 5:
            cell.Time.text = "周五"
        case 6:
            cell.Time.text = "周六"
        default :
            cell.Time.text =  "error"
        }
        if self.restTime.weekrest != nil {
            if let _ = self.restTime.weekrest.indexOf(indexPath.row.toString()){
                cell.activeLabel()
            }
        }
        cell.Time.userInteractionEnabled = false
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width:CGFloat = (collectionView.frame.width - 90)/7
        return CGSize(width: width, height: width*0.6)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TimeTableCell
        if !cell.isActive {
            cell.activeLabel()
        } else {
            cell.deactiveLabel()
        }
        
        if let i = self.restTime.weekrest.indexOf(indexPath.row.toString()) {
            self.restTime.weekrest.removeAtIndex(i)
            
        } else {
            self.restTime.weekrest.append(indexPath.row.toString())
        }
        self.RestDaysText.text = ""
        for item in self.restTime.weekrest {
            self.RestDaysText.text! += " \(Helper.intToWeekDay(Int(item)!))"
        }
    }
    
}
extension WorkingTimeConfigViewController:THDatePickerDelegate{
    func datePickerDonePressed(datePicker: THDatePickerViewController!) {
        dismissSemiModalView()
        if self.curTable == self.ExceptionLeaveTable {
            self.restTime.excep_rest.append(CVDate(date: datePicker.date).numDescription)
            self.ExceptionLeaveTable.reloadData()
        } else {
            self.restTime.excep_work.append(CVDate(date: datePicker.date).numDescription)
            self.ExceptionWorkingTable.reloadData()
        }
        
    }
    func datePickerCancelPressed(datePicker: THDatePickerViewController!) {
        dismissSemiModalView()
    }
    
}

extension WorkingTimeConfigViewController :  UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print(tableView.tag)
        print("xxxx")
        return 1
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("============")
        print(tableView.tag)
        print("============")
        let cell = tableView.dequeueReusableCellWithIdentifier("header") as! WorkingTimeSectionHeader
        if tableView == self.ExceptionLeaveTable {
            cell.Title.text = "休假"
           
        } else {
            cell.Title.text = "加班"
        }
        cell.addTapped = {
            ()->Void in
            self.curTable = tableView
            self.showDatePicker()
        }
        //cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        //cell.backgroundColor = O2Color.MainColor.colorWithAlphaComponent(0.9)
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.restTime.excep_work.count
        if self.restTime.weekrest == nil {
            return 0
        }
        if tableView == self.ExceptionWorkingTable {
            return self.restTime.excep_work.count
        } else {
            return self.restTime.excep_rest.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.ExceptionWorkingTable {
            let cell = tableView.dequeueReusableCellWithIdentifier("work", forIndexPath: indexPath) as! PlainTextCell
            let day = self.restTime.excep_work[indexPath.row]
            cell.PlainText.text = day
            cell.removeBtn.hidden = false
            cell.removeItem = {
                ()->Void in
                if let i = self.restTime.excep_work.indexOf(day) {
                    self.restTime.excep_work.removeAtIndex(i)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("leave", forIndexPath: indexPath) as! PlainTextCell
            let day = self.restTime.excep_rest[indexPath.row]
            cell.PlainText.text = day
            cell.removeBtn.hidden = false
            cell.removeItem = {
                ()->Void in
                if let i = self.restTime.excep_rest.indexOf(day) {
                    self.restTime.excep_rest.removeAtIndex(i)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
            return cell
        }
    }
    
}
