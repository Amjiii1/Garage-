//
//  SettingsViewController.swift
//  Garage
//
//  Created by Amjad Ali on 8/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

 
    @IBOutlet weak var settingContianerPop: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let GeneralNibView: GeneralView!
        GeneralNibView = Bundle.main.loadNibNamed("GeneralView", owner: self, options: nil)?[0] as! GeneralView
        GeneralNibView.frame.size = settingContianerPop.frame.size
        self.settingContianerPop.addSubview(GeneralNibView)
        
      
    }
    
     @IBAction func tabButtonaction(_ sender: UIButton) {
       
        let GeneralNibView: GeneralView!
        let HardwareNibView: HardwareView!
        let ReceiptNibView: ReceiptView!
        let QuickpayNibView: QuickpayView!
        let DatabaseNibView: DatabaseView!
        let LanguageNibView: LanguagesView!
        let AboutusNibView: AboutusView!
        let UpdatesNibView: UpdatesView!
        
        
        removeNibViews()
        
        switch sender.tag {
            
        case 1:
            GeneralNibView = Bundle.main.loadNibNamed("GeneralView", owner: self, options: nil)?[0] as! GeneralView
             GeneralNibView.frame.size = settingContianerPop.frame.size
            self.settingContianerPop.addSubview(GeneralNibView)
            break
        case 2:
            HardwareNibView = Bundle.main.loadNibNamed("HardwareView", owner: self, options: nil)?[0] as! HardwareView
            HardwareNibView.frame.size = settingContianerPop.frame.size
            self.settingContianerPop.addSubview(HardwareNibView)
            break
        case 3:
            ReceiptNibView = Bundle.main.loadNibNamed("ReceiptView", owner: self, options: nil)?[0] as! ReceiptView
            ReceiptNibView.frame.size = settingContianerPop.frame.size
            self.settingContianerPop.addSubview(ReceiptNibView)
            break
        case 4:
            QuickpayNibView = Bundle.main.loadNibNamed("QuickpayView", owner: self, options: nil)?[0] as! QuickpayView
            QuickpayNibView.frame.size = settingContianerPop.frame.size
            self.settingContianerPop.addSubview(QuickpayNibView)
            break
        case 5:
            
            DatabaseNibView = Bundle.main.loadNibNamed("DatabaseView", owner: self, options: nil)?[0] as! DatabaseView
            self.settingContianerPop.addSubview(DatabaseNibView)
            break
        case 6:
            LanguageNibView = Bundle.main.loadNibNamed("LanguagesView", owner: self, options: nil)?[0] as! LanguagesView
            self.settingContianerPop.addSubview(LanguageNibView)
            break
        case 7:
            AboutusNibView = Bundle.main.loadNibNamed("AboutusView", owner: self, options: nil)?[0] as! AboutusView
            self.settingContianerPop.addSubview(AboutusNibView)
            break
        case 8:
            UpdatesNibView = Bundle.main.loadNibNamed("UpdatesView", owner: self, options: nil)?[0] as! UpdatesView
            self.settingContianerPop.addSubview(UpdatesNibView)
            break
            
        default:
            break
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
        
        if let parentVC = (self.parent as? ReceptionalistView) {
            let storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as? MechanicView
            parentVC.switchViewController(vc: vc!, showFooter: true)
            
        }
        
        
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
