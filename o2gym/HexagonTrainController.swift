//
//  HexagonTrainController.swift
//  o2gym
//
//  Created by xudongbo on 9/30/15.
//  Copyright © 2015 royn. All rights reserved.
//

import UIKit
import LiquidFloatingActionButton

//private let reuseIdentifier = "Cell"

class HexagonTrainController: UICollectionViewController {


    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
    
    var alloptions : BodyEvalList!
    
    let orangeImage = UIImage(named: "emptyhexagon")
    let greyImage = UIImage(named: "emptyhexagon")!.add_tintedImageWithColor(O2Color.BorderGrey, style: ADDImageTintStyleKeepingAlpha)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.alloptions = BodyEvalList()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        
        
        let cellwidth:CGFloat = self.view.frame.width / 3 


        let flowLayout = PBJHexagonFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.headerReferenceSize = CGSizeZero
        flowLayout.footerReferenceSize = CGSizeZero
        flowLayout.itemSize = CGSizeMake(cellwidth , cellwidth  + 20)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemsPerRow = 4
        
        self.collectionView!.setCollectionViewLayout(flowLayout, animated: false)
        
        self.collectionView!.frame = CGRectMake(-cellwidth/2, 0, self.view.frame.width + cellwidth/2, self.view.frame.height)
        
        


        
        self.collectionView!.registerNib(UINib(nibName: "HexagonCell", bundle: nil), forCellWithReuseIdentifier: "hexagon")
  
        // Do any additional setup after loading the view.
        
        self.alloptions.load({ () -> Void in
            self.collectionView?.reloadData()
            }, itemcallback: nil)
        
        
        
        
        
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = LiquidFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self
            floatingActionButton.delegate = self
            floatingActionButton.enableShadow = false
            return floatingActionButton
        }
        
        let cellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            return LiquidFloatingCell(icon: UIImage(named: iconName)!)
        }
        cells.append(LiquidFloatingCell(icon: Helper.imageFromText("胸", attr: [NSFontAttributeName: UIFont.systemFontOfSize(24),
            NSForegroundColorAttributeName : UIColor.whiteColor()], size: CGSizeMake(30, 30))))
        cells.append(cellFactory("me"))
        cells.append(cellFactory("fav"))
        
        let floatingFrame = CGRect(x: self.view.bounds.width - 100, y: 400, width: 56, height: 56)
        let bottomRightButton = createButton(floatingFrame, .Up)
        
        print(floatingFrame)
        
        
        let floatingFrame2 = CGRect(x: 16, y: 16, width: 56, height: 56)
        let topLeftButton = createButton(floatingFrame2, .Down)
        
        self.view.addSubview(bottomRightButton)
        //self.view.addSubview(topLeftButton)
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if self.alloptions == nil {
            return 0
        } else {
            var ret = self.alloptions.count
            var c = ret
            var intval = 3
            repeat {
                c -= intval
                if intval == 3 {
                    ret += 1
                    intval = 2
                } else {
                    ret += 2
                    intval = 3
                }
            }  while( c > 0)
            return ret
        }
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hexagon", forIndexPath: indexPath) as! HexagonCell
    
        
        //calculate row
        if indexPath.row % 8 == 7 || indexPath.row % 8 == 4 {
            cell.Image.image = greyImage
        
        } else {
            cell.Image.image = orangeImage
        }
        //cell.Label.text =
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
//        print
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension HexagonTrainController: LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate {
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped! \(index)")
        floatingActionButton.close()
    }
}
