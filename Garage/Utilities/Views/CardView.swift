//
//  CardView.swift
//  Garage
//
//  Created by Amjad Ali on 8/7/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

var cardtype: String = ""

enum CardType: Int {
    case Visa = 1
    case MasterCard
    case AmericanExpress
    case Mada
    case Others
    
    var description: String {
        switch self {
        case .Visa:
            cardtype = "Visa"
            return "Visa"
        case .MasterCard:
            cardtype = "MasterCard"
            return "MasterCard"
        case .AmericanExpress:
            cardtype = "AmericanExpress"
            return "AmericanExpress"
        case .Mada:
            cardtype = "Mada"
            return "Mada"
        case .Others:
            cardtype = "Others"
            return "Others"
        }
    }
}

enum PaymentModeEnum: Int {
    case None = 0
    case Cash = 1
    case Card = 2
    case Void = 3
    case Partial = 4
    case CityLedger = 5
    case Loyalty = 6
    case GiftCard = 7
    case Coupon = 8
    case Multi = 9
    
}

class CardView: UIView {
    
    
    var cardHolderName: String?
    var cardNo:String?
    
    

    @IBOutlet weak var stackofCardButtons: UIStackView!
    
    @IBAction func btnCardTypeSelected(_ sender: Any) {
        deselectAllBtns()
        let button = sender as! UIButton
        button.isSelected = true
        button.layer.borderColor = UIColor.DefaultApp.cgColor
        button.layer.borderWidth = 2.0
        guard let value = CardType(rawValue: button.tag) else { return }
        
        switch value {
            
        case .Visa:
            print(value.description)
        case .MasterCard:
            print(value.description)
        case .AmericanExpress:
            print(value.description)
        case .Mada:
            print(value.description)
        case .Others:
            print(value.description)
        }
    }
    
    private func deselectAllBtns() {
        for i in 1...5 {
            if let button = stackofCardButtons.viewWithTag(i) as? UIButton {
                button.isSelected = false
                button.layer.borderColor = UIColor.white.cgColor
                button.layer.borderWidth = 2.0
            }
        }
    }
    
    
    @IBAction func cardNoEntered(_ sender: Any) {
        let cardtextField = sender as! UITextField
        if let text = cardtextField.text {
            print("cardNoEntered = \(text)")
            cardNo = text
        }
    }
    
    
    @IBAction func holderNameEntered(_ sender: Any) {
        let holdertxtField = sender as! UITextField
        if let text = holdertxtField.text {
            print("Holder Name = \(text)")
            cardHolderName = text
        }
    }
    
    
    
    

}
