//
//  ServiceCartView.swift
//  Garage
//
//  Created by Amjad Ali on 7/31/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class ServiceCartView: UIViewController {

    @IBOutlet weak var serviceSearch: UITextField!
    
    @IBOutlet weak var kilometers: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceSearch.attributedPlaceholder = NSAttributedString(string: "Search a Service Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtn(_ sender: Any) {
        if let parentVC = (self.parent as? ReceptionalistView) {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as? addNewCar
            parentVC.switchViewController(vc: vc!, showFooter: false)
            
                    }
    }
   
        
    

}
