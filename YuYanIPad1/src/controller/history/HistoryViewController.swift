//
//  HistoryViewController.swift
//  YuYanIPad1
//
//  Created by Yachen Dai on 3/20/15.
//  Copyright (c) 2015 cdyw. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController, HistoryChoiceProtocol, HistoryChoiceOfProductProtocol, HistoryResultProtocol
{
    @IBOutlet var topTitleBarView: UIView!
    @IBOutlet var titleBarBgImg: UIImageView!
    @IBOutlet var productContainerView: UIView!
    @IBOutlet var historyLeftView: UIView!
    @IBOutlet var leftControlBtn: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    var productViewA : ProductViewA?
    var switchToolView : SwitchToolView?
    var cartoonBarView : CartoonBarView?
    var historyChoiceView : HistoryChoiceView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.topTitleBarView.layer.masksToBounds = true
        self.leftControlBtn.selected = true
        // Init product view.
        self.productViewA = (NSBundle.mainBundle().loadNibNamed("ProductViewA", owner: self, options: nil) as NSArray).lastObject as? ProductViewA
        self.productViewA!.frame.origin = CGPointMake(0, 0)
        self.productContainerView.subviews.map { $0.removeFromSuperview() }
        self.productContainerView.addSubview(self.productViewA!)
        // Init tools of the switch at right bottom corner.
        self.switchToolView = (NSBundle.mainBundle().loadNibNamed("SwitchToolView", owner: self, options: nil) as NSArray).lastObject as? SwitchToolView
        self.switchToolView!.frame.origin = CGPointMake(738, 422)
        self.productContainerView.addSubview(self.switchToolView!)
        // Init tools of the cartoon bar at right bottom corner.
        self.cartoonBarView = (NSBundle.mainBundle().loadNibNamed("CartoonBarView", owner: self, options: nil) as NSArray).lastObject as? CartoonBarView
        self.cartoonBarView!.frame.origin = CGPointMake(332, 630)
        self.productContainerView.addSubview(self.cartoonBarView!)
        // Init main choice view.
        self.historyChoiceView = (NSBundle.mainBundle().loadNibNamed("HistoryChoiceView", owner: self, options: nil) as NSArray).lastObject as? HistoryChoiceView
        self.historyChoiceView!.frame.origin = CGPointMake(0, 0)
        self.historyLeftView.addSubview(self.historyChoiceView!)
        self.historyChoiceView?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if ProductModel.getInstance.isGetProductConfigArr() == false
        {
            ProductModel.getInstance.selectProductConfig()
        }
    }
    
    @IBAction func leftControlBtnClick(sender: UIButton)
    {
        sender.selected = !sender.selected
        if sender.selected == true
        {
//            if self.historyLeftView == nil
//            {
//                self.historyLeftView = (NSBundle.mainBundle().loadNibNamed("HistoryLeftView", owner: self, options: nil) as NSArray).lastObject as? HistoryLeftView
//                self.historyLeftView?.frame.origin = CGPointMake(-240, 0)
//                self.view.addSubview(self.historyLeftView!)
//            }
//            self.historyLeftView.segmentControlChanged(self.historyLeftView!.segmentControl)
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.topTitleBarView.frame.origin = CGPointMake(240, 0)
                self.topTitleBarView.frame.size = CGSizeMake(522, 48)
                self.historyLeftView.frame.origin = CGPointMake(0, 0)
                }, completion: { (Bool) -> Void in
                    self.titleBarBgImg.frame.size = CGSizeMake(464, 48)
            })
        }else{
            self.titleBarBgImg.frame.size = CGSizeMake(704, 48)
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.topTitleBarView.frame = CGRectMake(0, 0, 762, 48)
                self.historyLeftView.frame.origin = CGPointMake(-240, 0)
            })
        }
    }
    
    @IBAction func positionBtnClick(sender: UIButton)
    {
        sender.selected = !sender.selected
    }
    
    @IBAction func lineBtnClick(sender: UIButton)
    {
        sender.selected = !sender.selected
    }
    
    @IBAction func camaraBtnClick(sender: UIButton)
    {
        sender.selected = !sender.selected
    }
    
    // History Choice Protocol.
    var historyQueryLeftView : HistoryQueryLeftView?
    func historyQueryControl()
    {
        self.historyChoiceView?.removeFromSuperview()
        if self.historyQueryLeftView == nil
        {
            self.historyQueryLeftView = (NSBundle.mainBundle().loadNibNamed("HistoryQueryLeftView", owner: self, options: nil) as NSArray).lastObject as? HistoryQueryLeftView
            self.historyQueryLeftView?.historyResultProtocolDelegate = self
        }
        self.historyLeftView.addSubview(self.historyQueryLeftView!)
        self.historyQueryLeftView?.showQueryResult()
    }
    
    var historyChoiceOfProductView : HistoryChoiceOfProductView?
    func chooseProductControl()
    {
        self.historyChoiceView?.removeFromSuperview()
        if self.historyChoiceOfProductView == nil
        {
            self.historyChoiceOfProductView = (NSBundle.mainBundle().loadNibNamed("HistoryChoiceOfProductView", owner: self, options: nil) as NSArray).lastObject as? HistoryChoiceOfProductView
            self.historyChoiceOfProductView?.delegate = self
        }
        self.historyLeftView.addSubview(self.historyChoiceOfProductView!)
    }
    
    func chooseTimeControl()
    {
        
    }
    
    // History Choice of Product Protocol.
    func getSelectedProduct(productConfigVo : NSMutableDictionary)
    {
        self.historyLeftView?.subviews.map { $0.removeFromSuperview() }
        self.historyLeftView.addSubview(self.historyChoiceView!)
        self.historyChoiceView?.setProductBtnByVo(productConfigVo)
    }
    
    func returnBackToChoice()
    {
        self.historyLeftView?.subviews.map { $0.removeFromSuperview() }
        self.historyLeftView.addSubview(self.historyChoiceView!)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
    