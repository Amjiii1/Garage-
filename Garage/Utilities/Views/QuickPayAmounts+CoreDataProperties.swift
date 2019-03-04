//
//  QuickPayAmounts+CoreDataProperties.swift
//  Garage
//
//  Created by Amjad on 14/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import CoreData


extension QuickPayAmounts {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuickPayAmounts> {
        return NSFetchRequest<QuickPayAmounts>(entityName: "QuickPayAmounts")
    }
    
    @NSManaged public var amount: Double
    
}
