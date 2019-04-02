//
//  PrinterDetailsModel.swift
//  Garage
//
//  Created by Amjad on 13/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
enum PrinterManufacturer: String {
    case epson = "Epson"
    case star = "Star"
}

/// Model class to represent Printer's details object
class PrinterDetailsModel: NSObject {
    var model: String = ""
    var ipAddress: String = ""
    var target: String = ""
    var isCashPrinter: Bool = true
    var isKickDrawer: Bool = false
    var isKitchenPrinter: Bool = false
    var numberOfCopies: Int16 = 1
    var alias: String = ""
    var manufacturer: PrinterManufacturer? = nil
    var isConnected: Bool = true
    var macAddress: String = ""
    var isPrinting: Bool = false
}
