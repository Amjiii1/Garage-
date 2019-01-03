//
//  ViewController.swift
//  Garage
//
//  Created by Amjad Ali on 6/10/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    //var loginVc: LoginViewController
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
       // containerView.isHidden = true
//        let storyboardSettings = UIStoryboard(name: "Login", bundle: nil)
//        loginVc = storyboardSettings.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
//        self.addChildViewController(loginVc)
//        self.containerView.addSubview(loginVc.view)
//        loginVc.didMove(toParentViewController: self)
        
        
        self.addBadge(itemvalue: "3")
        
    }
    
    func addBadge(itemvalue: String) {
        
        let bagButton = BadgeButton()
        bagButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        bagButton.tintColor = UIColor.darkGray
        bagButton.setImage(UIImage(named: "heloo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bagButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        bagButton.badge = itemvalue
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bagButton)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





