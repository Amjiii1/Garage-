//
//  Discount+CoreDataProperties.swift
//  Garage
//
//  Created by Amjad on 13/01/1441 AH.
//  Copyright © 1441 Amjad Ali. All rights reserved.
//

import Foundation
import CoreData


extension Discount {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Discount> {
        return NSFetchRequest<Discount>(entityName: "Discount")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var typeOfDiscount: String
    @NSManaged public var unit: String
    @NSManaged public var value: Double
    
}
