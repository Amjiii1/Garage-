//
//  addNewCar.swift
//  Garage
//
//  Created by Amjad Ali on 7/11/18.
//  Copyright © 2018 Amjad Ali. All rights reserved

import UIKit

class addNewCar: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func backBtn(_ sender: Any) {
        
  
             self.willMove(toParentViewController: nil)
        
               self.removeFromParentViewController()
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
