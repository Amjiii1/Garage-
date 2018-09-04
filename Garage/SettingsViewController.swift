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
     
      
    }
    
     @IBAction func tabButtonaction(_ sender: UIButton) {
        
        let GeneralNibView: GeneralView!
        
        
        removeNibViews()
        
        switch sender.tag {
            
        case 1:
            GeneralNibView = Bundle.main.loadNibNamed("GeneralView", owner: self, options: nil)?[0] as! GeneralView
            self.settingContianerPop.addSubview(GeneralNibView)
        
            break
        case 2:
        settingContianerPop.backgroundColor = .red
            break
            
        case 3:
          settingContianerPop.backgroundColor = .blue
            break
            
        case 4:
           settingContianerPop.backgroundColor = .black
            break
            
        case 5:
             settingContianerPop.backgroundColor = .green
            break
        case 6:
           
            break
        case 7:
            print("Hello7")
            break
        case 8:
            print("Hello8")
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
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
