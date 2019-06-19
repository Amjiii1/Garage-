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
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        for i in 1...5 {
//            if (self.tabButtonsStackView.viewWithTag(i) as? UIButton) != nil {
//              
//            }
//        }
    
    
    DispatchQueue.main.async {
    // to open General tab by default
    if let button = self.tabButtonsStackView.viewWithTag(1) as? UIButton  {
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
        
        for childVC in self.childViewControllers {
            childVC.willMove(toParentViewController: nil)
            childVC.removeFromParentViewController()
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
        //    childVC = UIStoryboard(name: "Aboutus", bundle: nil).instantiateViewController(withIdentifier: "AboutusVCID") as? AboutusViewController
        case .Updates:
            childVC = UIStoryboard(name: Constants.Updates, bundle: nil).instantiateViewController(withIdentifier: Constants.UpdatesVCID) as? UpdatesViewController
        }
        
        if childVC != nil {
            childVC?.view.frame.size = settingContianerPop.frame.size
            childVC?.view.frame.origin = CGPoint(x: 0, y: 0)
            addChildViewController(childVC!)
            settingContianerPop.addSubview((childVC?.view)!)
            childVC?.didMove(toParentViewController: self)
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
