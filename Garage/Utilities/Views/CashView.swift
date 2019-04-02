//
//  CashView.swift
//  Garage
//
//  Created by Amjad Ali on 8/7/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit
import CoreData



protocol CashViewDelegate: class {
    func PayAmountTapped(amount: Double)
}


class CashView: UIView {

    @IBOutlet weak var stackView1: UIStackView!
    
    @IBOutlet weak var stackview2: UIStackView!
    
    
    weak var delegate: CashViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       updateFirstButtonAmount()
        NotificationCenter.default.addObserver(self, selector: #selector(CashView.pressed(notification:)), name: Notification.Name("buttonpressed"), object: nil)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("buttonpressed"), object: nil)
        
    }
    
    
    
    
    @objc func pressed(notification: Notification) {
        self.updateFirstButtonAmount()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
         updateFirstButtonAmount()
    }
    
    func updateFirstButtonAmount(){
        //set balance as first button amount
       // if let parent = self.parentContainerViewController as? CheckOutPopView {
            if let button1 = stackView1.viewWithTag(1) as? UIButton {
              let balance = Constants.checkoutGrandtotal //{
                   let doubleBalance = Double(balance) //{
                        if doubleBalance > 0.0 {
                            button1.setTitle(String(format: "%.2f", balance), for: .normal)
                            return
                        }
                   // }
               // }
                button1.setTitle(String(format: "1.0"), for: .normal)
                
            }
       // }
    }
    
   
    @IBAction func tapAmount(_ sender: UIButton) {
        
        if let str = sender.titleLabel?.text {
            let doubleAmount = Double(str)
            if let doubleAmount = doubleAmount {
                delegate?.PayAmountTapped(amount: doubleAmount)
            }
        }
    }
    
    
    
    
    
    
    

}
