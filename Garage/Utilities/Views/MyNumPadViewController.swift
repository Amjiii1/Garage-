//
//  MyNumPadViewController.swift
//  Garage
//
//  Created by Amjad on 11/01/1441 AH.
//  Copyright © 1441 Amjad Ali. All rights reserved.
//

import UIKit

class MyNumPadViewController: UIViewController {
    
    
    @IBOutlet weak var txtFieldAmountEnter: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBumberTapped(_ sender: Any) {
        
        if var strAmount = txtFieldAmountEnter.text {
            if let sender = sender as? UIButton {
                if let text = sender.titleLabel?.text {
                    strAmount = strAmount + text
                    txtFieldAmountEnter.text = strAmount
                }
                else {
                    strAmount = String(strAmount.dropLast())
                    txtFieldAmountEnter.text = strAmount
                }
            }
        }
    }
    
    deinit {
        print("MyNumPadViewController deinit")
        
        
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
