//
//  SettingsViewController.swift
//  Garage
//
//  Created by Amjad Ali on 8/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var settingContianerPop: UIView!
    
    @IBOutlet weak var tabButtonsStackView: UIStackView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var generalBtn: UIButton!
    @IBOutlet weak var hardwareBtn: UIButton!
    @IBOutlet weak var receiptBtn: UIButton!
    @IBOutlet weak var quickpayBtn: UIButton!
    @IBOutlet weak var databaseBtn: UIButton!
    @IBOutlet weak var languageBtn: UIButton!
    @IBOutlet weak var aboutusBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    
    @IBOutlet weak var topview: UIView!
    
    
    
    enum SettingViews: Int {
        case General = 1
        case Hardware
        case Receipt
        case QuickPay
        case DataBase
        case Language
        case Aboutus
        case Updates
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tabButtonsStackView.backgroundColor = UIColor.white
         dismiss(animated: true, completion: nil)
    }
    
   
    
    override func viewDidLayoutSubviews() {
        saveBtn.layer.shadowColor = UIColor.gray.cgColor
        saveBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        saveBtn.layer.masksToBounds = false
        saveBtn.layer.shadowRadius = 14
        saveBtn.layer.shadowOpacity = 1
        
        generalBtn.layer.shadowColor = UIColor.gray.cgColor
        generalBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        generalBtn.layer.masksToBounds = false
        generalBtn.layer.shadowRadius = 1
        generalBtn.layer.shadowOpacity = 0.1
//        generalBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left:40, bottom: 30, right: 0)
//        generalBtn.titleEdgeInsets = UIEdgeInsetsMake(20,0,0,30)
        
        hardwareBtn.layer.shadowColor = UIColor.gray.cgColor
        hardwareBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        hardwareBtn.layer.masksToBounds = false
        hardwareBtn.layer.shadowRadius = 1
        hardwareBtn.layer.shadowOpacity = 0.1
        
        receiptBtn.layer.shadowColor = UIColor.gray.cgColor
        receiptBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        receiptBtn.layer.masksToBounds = false
        receiptBtn.layer.shadowRadius = 1
        receiptBtn.layer.shadowOpacity = 0.1
        
        quickpayBtn.layer.shadowColor = UIColor.gray.cgColor
        quickpayBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        quickpayBtn.layer.masksToBounds = false
        quickpayBtn.layer.shadowRadius = 1
        quickpayBtn.layer.shadowOpacity = 0.1
//        
//        databaseBtn.layer.shadowColor = UIColor.gray.cgColor
//        databaseBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        databaseBtn.layer.masksToBounds = false
//        databaseBtn.layer.shadowRadius = 1
//        databaseBtn.layer.shadowOpacity = 0.1
        
        languageBtn.layer.shadowColor = UIColor.gray.cgColor
        languageBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        languageBtn.layer.masksToBounds = false
        languageBtn.layer.shadowRadius = 1
        languageBtn.layer.shadowOpacity = 0.1
        
        aboutusBtn.layer.shadowColor = UIColor.gray.cgColor
        aboutusBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        aboutusBtn.layer.masksToBounds = false
        aboutusBtn.layer.shadowRadius = 1
        aboutusBtn.layer.shadowOpacity = 0.1
        
        updateBtn.layer.shadowColor = UIColor.gray.cgColor
        updateBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        updateBtn.layer.masksToBounds = false
        updateBtn.layer.shadowRadius = 1
        updateBtn.layer.shadowOpacity = 0.1
        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.updateBtn.bounds
//        gradientLayer.colors = [UIColor.gray.cgColor, UIColor.white.cgColor]
//        self.updateBtn.layer.insertSublayer(gradientLayer, at: 5)
        
        topview.layer.shadowColor = UIColor.gray.cgColor
        topview.layer.shadowOpacity = 0.5
        topview.layer.shadowOffset = .zero
        topview.layer.shadowRadius = 1
        topview.layer.shadowPath = UIBezierPath(rect: topview.bounds).cgPath
        topview.layer.shouldRasterize = true
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
//        for i in 1...5 {
//            if (self.tabButtonsStackView.viewWithTag(i) as? UIButton) != nil {
//              
//            }
//        }
    
    
    DispatchQueue.main.async {
    // to open General tab by default
    if let button = self.tabButtonsStackView.viewWithTag(2) as? UIButton  {
    print(button)
    self.tabButtonaction(button)
    }
    }
}
    
    
    
    @IBAction func tabButtonaction(_ sender: UIButton) {
        
        
        for i in 1...8 {
            if let button = self.tabButtonsStackView.viewWithTag(i) as? UIButton {
                button.isSelected = false
            }
        }
        sender.isSelected = true
        addChildView(index: sender.tag)
    }
    
    

    
    
    func addChildView(index: Int) {
        
        for childVC in self.children {
            childVC.willMove(toParent: nil)
            childVC.removeFromParent()
            childVC.view.removeFromSuperview()
        }
        
        var childVC: UIViewController?
        
        guard let value = SettingViews(rawValue: index) else { return }
        
        switch value {
            
        case .General:
            childVC = UIStoryboard(name: Constants.General, bundle: nil).instantiateViewController(withIdentifier: Constants.GeneralVCID) as? GeneralViewController
            break
        case .Hardware:
            childVC = UIStoryboard(name: Constants.Hardware, bundle: nil).instantiateViewController(withIdentifier: Constants.HardwareVCID) as? HardwareViewController
        case .Receipt:
            childVC = UIStoryboard(name: Constants.Receipt, bundle: nil).instantiateViewController(withIdentifier: Constants.ReceiptVCID) as? ReceiptViewController
        case .QuickPay:
            childVC = UIStoryboard(name: Constants.QuickPay, bundle: nil).instantiateViewController(withIdentifier: Constants.QuickPayVCID) as? QuickPayViewController
        case .DataBase:
            childVC = UIStoryboard(name: Constants.Database, bundle: nil).instantiateViewController(withIdentifier: Constants.DatabaseVCID) as? DatabaseViewController
        case .Language:
            childVC = UIStoryboard(name: Constants.Language, bundle: nil).instantiateViewController(withIdentifier: Constants.LanguageVCID) as? LanguageViewController
        case .Aboutus:
            print("Aboutus tapped")
           childVC = UIStoryboard(name: "Aboutus", bundle: nil).instantiateViewController(withIdentifier: "AboutusVCID") as? AboutusViewController
        case .Updates:
            childVC = UIStoryboard(name: Constants.Updates, bundle: nil).instantiateViewController(withIdentifier: Constants.UpdatesVCID) as? UpdatesViewController
        }
        
        if childVC != nil {
            childVC?.view.frame.size = settingContianerPop.frame.size
            childVC?.view.frame.origin = CGPoint(x: 0, y: 0)
            addChild(childVC!)
            settingContianerPop.addSubview((childVC?.view)!)
            childVC?.didMove(toParent: self)
        }
    }
    
    
    func removeNibViews() {
        if settingContianerPop.subviews.count > 0  {
            let views:[UIView] = settingContianerPop.subviews
            for view in views  {
                view.removeFromSuperview()
                
            }
            
        }
        
        
    }
    
    
    
    @IBAction func savecloseBtn(_ sender: Any) {
       dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func dismissSettings(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    func myButtonTapped(){
        //        if  UIButton.isSelected == true {
        //            UIButton.isSelected = false
        //        }   else {
        //            UIButton.isSelected = true
        //        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
