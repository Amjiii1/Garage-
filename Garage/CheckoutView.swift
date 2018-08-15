//
//  CheckoutView.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class CheckoutView: UIViewController {

    
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var popContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
   
    
    
    @IBAction func ChecoutTest(_ sender: Any) {
        
            let storyboard = UIStoryboard(name: "CheckoutPopUp", bundle: nil)
            let carScanner = storyboard.instantiateViewController(withIdentifier: "CheckOutPopVc") as! CheckOutPopView
        self.addChildViewController(carScanner)
        view.addSubview(carScanner.view)
       
    }
    
    
    func setupConstraints(){
       

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
