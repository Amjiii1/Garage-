//
//  PrinterDetails+CoreDataProperties.swift
//  Garage
//
//  Created by Amjad on 07/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import CoreData


extension PrinterDetails {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrinterDetails> {
        return NSFetchRequest<PrinterDetails>(entityName: "PrinterDetails")
    }
    
    @NSManaged public var alias: String!
    @NSManaged public var ipAddress: String!
    @NSManaged public var isCashPrinter: Bool
    @NSManaged public var isKickDrawer: Bool
    @NSManaged public var isKitchenPrinter: Bool
    @NSManaged public var manufacturer: String
    @NSManaged public var model: String!
    @NSManaged public var numberOfCopies: Int16
    @NSManaged public var target: String!
    @NSManaged public var macAddress: String
    
}
