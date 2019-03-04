//
//  QuickPayViewController.swift
//  Garage
//
//  Created by Amjad on 14/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import CoreData

class QuickPayViewController: UIViewController {

    @IBOutlet weak var textFieldContainerView: UIView!
    
    fileprivate var updatedQuickPayAmounts: [Double] = [Double]()
    private var quickPayAmount: [QuickPayAmounts]?
    
    fileprivate var currentAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quickPayAmount = getQuickPayAmounts()
        for item in quickPayAmount! {
            updatedQuickPayAmounts.append(item.amount)
        }
        updatedQuickPayAmounts.sort()
        setupUI()
    }
    
    // MARK:- UI Related Methods
    
    func setupUI() {
        for i in 100...107 {
            if let textField = textFieldContainerView.viewWithTag(i) as? UITextField {
                textField.delegate = self
                textField.layer.cornerRadius = 8
                textField.text = String(format: "%g", updatedQuickPayAmounts[i%100])
            }
        }
    }
    
    // MARK:- CoreData Related Methods
    
    /// Gets QuickPay Amounts from DB
    ///
    /// - Returns: [QuickPayAmounts]?
    fileprivate func getQuickPayAmounts()-> [QuickPayAmounts]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuickPayAmounts")
        do {
            let results = [QuickPayAmounts]()
            return results
            
        } catch {
            print("error in retrieving")
            return nil
        }
    }
    
    /// Updates QuickPay Amounts in DB
    ///
    /// - Parameters:
    ///   - updatedAmount: Double
    fileprivate func updateQuickPayAmount(updatedAmount: Double) {
        let fetchRequest: NSFetchRequest = QuickPayAmounts.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "amount == %f", currentAmount)
        do {
            let results = try DataController.context.fetch(fetchRequest)
            results.first?.amount = updatedAmount
            try DataController.context.save()
        } catch {
            
        }
    }
    
}

extension QuickPayViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentAmount = updatedQuickPayAmounts[textField.tag%100]
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text?.isEmpty)! {
            textField.text = updatedQuickPayAmounts[textField.tag%100].description
        } else {
            updatedQuickPayAmounts[textField.tag%100] = Double(textField.text!)!
            textField.text = String(format: "%g", updatedQuickPayAmounts[textField.tag%100])
            self.updateQuickPayAmount(updatedAmount: updatedQuickPayAmounts[textField.tag%100])
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let numberString = text.replacingCharacters(in: textRange, with: string)
            if Double(numberString) == nil {
                UIUtility.shakeView(view: textField)
                return false
            }
        }
        return true
    }
}
