//
//  PrinterContext.swift
//  Garage
//
//  Created by Amjad on 13/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation
import UIKit

protocol PrinterContextDelegate: class {
    /// call this method when the printer has printed given data
    func didPrint()
}

class PrinterContext {
    
    private var strategy: Printable!
    
    var delegate: PrinterContextDelegate?
    
    /// Overloaded constructor
    ///
    /// - Parameters:
    ///   - strategy: An instance of a class conforming Printable
    init(strategy: Printable) {
        self.strategy = strategy
    }
    
    // MARK:- Public Methods
    
    func printReceipt(printerDetailsModel: PrinterDetailsModel, printImage: UIImage, isKickDrawer: Bool = false, completion: @escaping (Bool, String)->()) {
        strategy.printReceipt(printerDetailsModel: printerDetailsModel, imageToPrint: printImage, isKickDrawer: isKickDrawer, printerContextDelegate: delegate!) { (isSuccess, message) in
            completion(isSuccess, message)
        }
    }
}
