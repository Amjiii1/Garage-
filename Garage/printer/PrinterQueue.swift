//
//  PrinterQueue.swift
//  Garage
//
//  Created by Amjad on 26/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class PrinterQueue: NSObject {
    
    
    var currentPrinter:Printer!
        var isXreport:Bool!
    var xReportObject:Xreport!
   
    
    init(currentPrinter:Printer) {
        self.currentPrinter = currentPrinter
       
    }
    
    
    init(xReport:Bool) {
        self.isXreport = true
    }

}
