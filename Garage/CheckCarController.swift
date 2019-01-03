//
//  CheckCarController.swift
//  Garage
//
//  Created by Amjad on 18/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class CheckCarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func backBtn(_ sender: Any) {
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "MechanicView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MechanicVc") as? MechanicView
            parentVC.switchViewController(vc: vc!, showFooter: true)
        }
    }
    
    

}
