//
//  DiscountViewModel.swift
//  Garage
//
//  Created by Amjad on 19/01/1441 AH.
//  Copyright © 1441 Amjad Ali. All rights reserved.
//

import Foundation




struct discountModel{
    var name: String
    var amount: String
    var currencySymbol: String
}

class DiscountViewModel {
    
    var titleText: String = ""
    var amountText: String = ""
    var currencyText: String = ""
    
    var discountModels: [discountModel] = []
    
    //MARK:- initializer / deinitializer
    init() {
    }
    
    deinit {
        print("userViewModel getting deinitialized")
    }
    
    func setDiscountViewModels() {
        let discountModel1 = discountModel(name: "National Day", amount: "10", currencySymbol: "SAR")
        let discountModel2 = discountModel(name: "Father's Day", amount: "5", currencySymbol: "%")
        let discountModel3 = discountModel(name: "Happiness Day", amount: "3", currencySymbol: "SAR")
        discountModels.append(discountModel1)
        discountModels.append(discountModel2)
        discountModels.append(discountModel3)
    }
    
    func getDiscountModelAt(index: Int) -> DiscountViewModel{
        let discountModelObj = discountModels[index]
        
        self.titleText = discountModelObj.name
        self.amountText = discountModelObj.amount
        self.currencyText = discountModelObj.currencySymbol
        return self
    }
}
