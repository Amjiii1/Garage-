//
//  MechanicView.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class MechanicView: UIViewController {

    @IBOutlet weak var Subview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func SeetingsBtnexp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        let setting = storyboard.instantiateViewController(withIdentifier: "SettingViewControllerVc") as! SettingsViewController
        
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            setting.view.frame = vc.view.frame
            vc.addChildViewController(setting)
            vc.view.addSubview(setting.view)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.parent as? ReceptionalistView {
            vc.addFooterView1(selected: 1)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
