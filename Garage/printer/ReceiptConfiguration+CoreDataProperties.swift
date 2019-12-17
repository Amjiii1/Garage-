//
//  ReceiptConfiguration+CoreDataProperties.swift
//  Garage
//
//  Created by Amjad on 07/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import CoreData


extension ReceiptConfiguration {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReceiptConfiguration> {
        return NSFetchRequest<ReceiptConfiguration>(entityName: "ReceiptConfiguration")
    }
    
    @NSManaged public var isPrintReceipt: Bool
    @NSManaged public var showvalueAddedTaxNumber: Bool
    @NSManaged public var showlocation: Bool
    @NSManaged public var showcashier: Bool
    @NSManaged public var showKitchenHangingSpace: Bool
    @NSManaged public var showLogo: Bool
    @NSManaged public var showNotes: Bool
    @NSManaged public var showPhone: Bool
    @NSManaged public var showvin: Bool
    @NSManaged public var showTable: Bool
    
    
}
