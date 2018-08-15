//
//  WelcomeView.swift
//  Garage
//
//  Created by Amjad Ali on 7/9/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController {
    
    @IBOutlet var welcomeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.parent as? ReceptionalistView {
            vc.addFooterView1(selected: 0)
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        if let vc = self.parent as? ReceptionalistView {
//            vc.removeFooterView()
//        }
//    }
    
    @IBAction func carScannerBtn(_ sender: Any) {
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "CarScan", bundle: nil)
            let carScanner = storyboard.instantiateViewController(withIdentifier: "carScannerVc") as!CarScannerView
            vc.switchViewController(vc: carScanner, showFooter: false)
        }
    }
    
    @IBAction func addNewCarBtn(_ sender: Any) {
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let newCarvc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as! addNewCar
            vc.switchViewController(vc: newCarvc, showFooter: false)
        }
    }
    
    
   
 }


