//
//  ReceiptViewController.swift
//  Garage
//
//  Created by Amjad on 21/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit
import CoreData



enum PermissionIndex: Int {
    case showLogo = 0
    case showCompany
    case showAddress
    case showPhone
    case showEmail
    case showWebsite
    case showNotes
    case showTable
}

enum ReceiptSettingIndex: Int {
    case isPrintReceipt = 0
    case showKitchenHangingSpace
}

class ReceiptViewController: UIViewController {

    
    @IBOutlet weak var PrintReceiptSwitch: UISwitch!
    @IBOutlet weak var LogoSwitch: UISwitch!
    @IBOutlet weak var CompanyNameSwitch: UISwitch!
    @IBOutlet weak var VinSwitch: UISwitch!
    @IBOutlet weak var EmailSwitch: UISwitch!
    @IBOutlet weak var WebSwitch: UISwitch!
    
    
    
    
    
    private var selectedReceiptOptions = [false, false]
    private var selectedPermissions = [false, false, false, false, false, false, false, false]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//setupConfiguration()

        
    }
    
    private func getReceiptConfiguration()-> ReceiptConfiguration? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ReceiptConfiguration")
        do {
            let results = try DataController.context.fetch(fetchRequest) as! [ReceiptConfiguration]
            return results.first
        } catch {
            print("error in retrieving")
            return nil
        }
    }
    
    func setupConfiguration() {
        if let configuration = getReceiptConfiguration() {
            selectedReceiptOptions[ReceiptSettingIndex.isPrintReceipt.rawValue] = configuration.isPrintReceipt
            selectedReceiptOptions[ReceiptSettingIndex.showKitchenHangingSpace.rawValue] = configuration.showKitchenHangingSpace
            selectedPermissions[PermissionIndex.showLogo.rawValue] = configuration.showLogo
            selectedPermissions[PermissionIndex.showCompany.rawValue] = configuration.showlocation
            selectedPermissions[PermissionIndex.showAddress.rawValue] = configuration.showvalueAddedTaxNumber
            selectedPermissions[PermissionIndex.showPhone.rawValue] = configuration.showPhone
            selectedPermissions[PermissionIndex.showEmail.rawValue] = configuration.showcashier
            selectedPermissions[PermissionIndex.showWebsite.rawValue] = configuration.showvin
            selectedPermissions[PermissionIndex.showNotes.rawValue] = configuration.showNotes
            selectedPermissions[PermissionIndex.showTable.rawValue] = configuration.showTable
        } else {
            saveReceiptConfiguration()
            PrintJobHelper.setReceiptConfigurationModel()
        }
    }
    
    /// Updates Receipt Configuration in DB
    ///
    /// - Returns: Void
    private func updateReceiptConfiguration() {
        let fetchRequest: NSFetchRequest = ReceiptConfiguration.fetchRequest()
        do {
            let result = try DataController.context.fetch(fetchRequest).first
            result?.isPrintReceipt = selectedReceiptOptions[ReceiptSettingIndex.isPrintReceipt.rawValue]
            result?.showKitchenHangingSpace = selectedReceiptOptions[ReceiptSettingIndex.showKitchenHangingSpace.rawValue]
            result?.showLogo = selectedPermissions[PermissionIndex.showLogo.rawValue]
            result?.showlocation = selectedPermissions[PermissionIndex.showCompany.rawValue]
            result?.showvalueAddedTaxNumber = selectedPermissions[PermissionIndex.showAddress.rawValue]
            result?.showPhone = selectedPermissions[PermissionIndex.showPhone.rawValue]
            result?.showcashier = selectedPermissions[PermissionIndex.showEmail.rawValue]
            result?.showvin = selectedPermissions[PermissionIndex.showWebsite.rawValue]
            result?.showNotes = selectedPermissions[PermissionIndex.showNotes.rawValue]
            result?.showTable = selectedPermissions[PermissionIndex.showTable.rawValue]
            try DataController.context.save()
        } catch {
            print("Error occured")
        }
    }
    
    
    @IBAction func ReceiptPrintAction(_ sender: Any) {
        
//        if PrintReceiptSwitch.isOn == true {
//
//            self.updateReceiptConfiguration()
//            PrintJobHelper.setReceiptConfigurationModel()
//        } else {
//            PrintReceiptSwitch.isOn = false
//            print("Its off now!")
//        }
        
        
    }
    
   
    
    
    
    
    
    
    
    
    /// Saves ReceiptConfiguration in DB
    ///
    /// - Returns: Void
    private func saveReceiptConfiguration() {
        do {
            let itemCount = try DataController.context.count(for: ReceiptConfiguration.fetchRequest())
            if itemCount == 0 {
                let context = DataController.context
                guard let entity =  NSEntityDescription.entity(forEntityName: "ReceiptConfiguration", in: context) else { return }
                let object = ReceiptConfiguration(entity: entity, insertInto: context)
                object.isPrintReceipt = selectedReceiptOptions[ReceiptSettingIndex.isPrintReceipt.rawValue]
                object.showKitchenHangingSpace = selectedReceiptOptions[ReceiptSettingIndex.showKitchenHangingSpace.rawValue]
                object.showLogo = selectedPermissions[PermissionIndex.showLogo.rawValue]
                object.showlocation = selectedPermissions[PermissionIndex.showCompany.rawValue]
                object.showvalueAddedTaxNumber = selectedPermissions[PermissionIndex.showAddress.rawValue]
                object.showPhone = selectedPermissions[PermissionIndex.showPhone.rawValue]
                object.showcashier = selectedPermissions[PermissionIndex.showEmail.rawValue]
                object.showvin = selectedPermissions[PermissionIndex.showWebsite.rawValue]
                object.showNotes = selectedPermissions[PermissionIndex.showNotes.rawValue]
                object.showTable = selectedPermissions[PermissionIndex.showTable.rawValue]
                try DataController.context.save()
                
            }
        } catch {
            print("Error occured")
        }
    }

    
    
    
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        UIUtility.showAlertInController(title: "Sorry", message: "Functionality will be available soon", viewController: self)
        
    }
   
    
    
    
    
    
    
    

}
