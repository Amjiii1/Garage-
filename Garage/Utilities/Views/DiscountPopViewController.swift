//
//  DiscountPopViewController.swift
//  Garage
//
//  Created by Amjad on 10/01/1441 AH.
//  Copyright © 1441 Amjad Ali. All rights reserved.
//

import UIKit
import CoreData


enum DiscountTypeString: String {
    case Amount = "Amount"
    case Percentage
    case Trend
}

protocol DiscountPopDelegate: class {
    func discountApplyPressed(viewController: UIViewController)
    func discountCancelPressed(viewController: UIViewController)
}



class DiscountPopViewController: UIViewController {
    
    let discountCellIdentifier = "discountCellIdentifier"
    let discountViewModel = DiscountViewModel()
    
    @IBOutlet weak var discountContainerView: UIView!
    
    @IBOutlet weak var discountTableview: UITableView!
    @IBOutlet weak var stackOfTopButtons: UIStackView!
    weak var delegate: DiscountPopDelegate?
    var numPadVC: MyNumPadViewController?
    var selectedDiscountType:DiscountType!
    
    
    
    
    
    
    enum DiscountType: Int, CustomStringConvertible {
        var description: String {
            switch self {
            case .Amount:
                return "Amount"
            case .Percentage:
                return "Percentage"
            case .Trend:
                return "Trend"
            }
        }
        
        case Percentage = 1
        case Amount
        case Trend
    }
    
    
    @IBAction func applyPressed(_ sender: Any) {
        saveDiscount()
        self.delegate?.discountApplyPressed(viewController: self)
        // self.delegate?.discountCancelPressed(viewController: self)
    }
    
    
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        resetDiscount()
        self.delegate?.discountCancelPressed(viewController: self)
    }
    
    
    func saveDiscount(){
        
        Common.resetAllRecords(in: "Discount")
        if let textAmountEntered = numPadVC?.txtFieldAmountEnter.text {
            if let numericAmount = Double(textAmountEntered) {
                
                guard let discountEntity =  NSEntityDescription.entity(forEntityName: "Discount", in: DataController.context) else { return }
                let discount = Discount(entity: discountEntity, insertInto: DataController.context)
                discount.value = numericAmount
                discount.typeOfDiscount = selectedDiscountType.description
                discount.unit = selectedDiscountType.description //since right now only amount and percentage in working so it can represent unit as well
                DataController.saveContext()
            }
        }
    }
    
    private func resetDiscount() {
        numPadVC?.txtFieldAmountEnter.text = ""
        Common.resetAllRecords(in: "Discount")
    }
    
    
    
    
    
    
    @IBAction func topdiscountbuttons(_ sender: Any) {
        
        guard let button = sender as? UIButton else { return }
        guard let value = DiscountType(rawValue: button.tag) else { return }
        
        for subview in stackOfTopButtons.arrangedSubviews {
            if let subview = subview as? UIButton {
                subview.isSelected = false
            }
        }
        button.isSelected = true
        discountTableview.isHidden = true
        if let numPadVC = numPadVC {
            Common.hideContentController(childController: numPadVC)
        }
        selectedDiscountType = value
        
        switch value {
            
        case .Percentage:
            
            numPadVC = MyNumPadViewController(nibName: "MyNumPadViewController", bundle: nil)
            Common.addChildController(childController: numPadVC!, onParent: self, onView: discountContainerView)
            numPadVC!.symbolLabel.text = "%"
        case .Amount:
            numPadVC = MyNumPadViewController(nibName: "MyNumPadViewController", bundle: nil)
            Common.addChildController(childController: numPadVC!, onParent: self, onView: discountContainerView)
            numPadVC!.symbolLabel.text = "SAR"
            
        case .Trend:
            discountTableview.isHidden = false
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nib = UINib.init(nibName: "DiscountTableViewCell", bundle: nil)
        discountTableview.register(nib, forCellReuseIdentifier: discountCellIdentifier)
        discountViewModel.setDiscountViewModels()
        
        
        if let amountButton = stackOfTopButtons.viewWithTag(2) as? UIButton {
            topdiscountbuttons(amountButton)
        }
        
        
        
        
        
    }
    
    
}

extension DiscountPopViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return discountViewModel.discountModels.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//discountViewModel.discountModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: discountCellIdentifier, for: indexPath) as! DiscountTableViewCell
        let discountObj: DiscountViewModel = discountViewModel.getDiscountModelAt(index: indexPath.section)
        cell.lblTitle.text = discountObj.titleText
        cell.lblAmount.text = discountViewModel.amountText
        cell.lblCurrency.text = discountViewModel.currencyText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = discountTableview.cellForRow(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.DefaultApp.cgColor
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = discountTableview.cellForRow(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.clear.cgColor
        
    }
}


