

//
//  Printable.swift
//  Garage
//
//  Created by Amjad on 13/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import UIKit

/// This protocol defines the blueprint methods or requirements related to Printability of a printer
protocol Printable {
    
    /// Prints receipt
    /// - Parameters:
    ///     - printerDetailsModel: PrinterDetailsModel
    ///     - imageToPrint: UIImage
    ///     - isKickDrawer: Bool
    ///     - printerContextDelegate: PrinterContextDelegate
    /// - Returns: @escaping (Bool, String) -> ()
    func printReceipt(printerDetailsModel: PrinterDetailsModel, imageToPrint: UIImage, isKickDrawer: Bool, printerContextDelegate: PrinterContextDelegate, completion: @escaping (Bool, String) -> ())
    
}
