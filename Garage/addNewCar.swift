//
//  addNewCar.swift
//  Garage
//
//  Created by Amjad Ali on 7/11/18.
//  Copyright © 2018 Amjad Ali. All rights reserved

import UIKit
import IQKeyboardManager

class addNewCar: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.parent as? ReceptionalistView {
            vc.removeFooterView()
        }
    }
    
    
    @IBAction func reScannerBtn(_ sender: Any) {
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "CarScan", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "carScannerVc") as?CarScannerView
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }
    }
    
    
    @IBAction func continueBtnServiceCart(_ sender: Any) {
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "ServiceCart", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ServiceCartVc") as? ServiceCartView
            parentVC.switchViewController(vc: vc!, showFooter: false)
        }
        
    }
    
    
    
    

    @IBAction func backBtn(_ sender: Any) {
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "WelcomeView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeVc") as? WelcomeView
            parentVC.switchViewController(vc: vc!, showFooter: true)
          
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
