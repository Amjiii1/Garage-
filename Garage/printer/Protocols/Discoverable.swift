//
//  Discoverable.swift
//  Garage
//
//  Created by Amjad on 13/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation

/// This protocol defines the blueprint methods or requirements related to Discovery of a printer
protocol Discoverable {
    
    /// Start searching for printers on LAN
    /// - Returns: @escaping (Bool, String) -> ()
    func startSearchingOnLAN(completion: @escaping (Bool, String) -> ())
    
    /// Start searching for printers on Bluetooth
    /// - Returns: @escaping (Bool, String) -> ()
    func startSearchingOnBluetooth(completion: @escaping (Bool, String) -> ())
    
    /// Stops searching for printers
    /// - Returns: @escaping (Bool, String) -> ()
    func stopSearching(completion: @escaping (Bool, String) -> ())
}
