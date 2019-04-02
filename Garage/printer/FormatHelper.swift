//
//  FormatHelper.swift
//  Garage
//
//  Created by Amjad on 07/07/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation


enum DateFormat: String {
    case shortDate = "MM/dd/yy"
}

enum TimeFormat: String {
    case hour12 = "h:mm a"
}

class FormatHelper {
    
    /// Formats date into en-US format
    ///
    /// - Parameters:
    ///   - date: Date object to format
    ///   - dateFormat: Format String
    /// - Returns: Formatted date string
    class func getFormattedDateString(date: Date, dateFormat: String = "yyyy-MM-dd-HH-mm-ss") -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en-US")
        print(date, dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
    
    /// Returns formatted date string
    /// - Parameters:
    ///     - date: NSDate
    ///     - dateFormat: DateFormat
    /// - Returns: String
    class func getFormattedDate(date: NSDate, dateFormat: DateFormat)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: date as Date)
    }
    
    /// Returns formatted time string
    /// - Parameters:
    ///     - date: NSDate
    ///     - timeFormat: TimeFormat
    /// - Returns: String
    class func getFormattedTime(date: NSDate, timeFormat: TimeFormat)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timeFormat.rawValue
        return dateFormatter.string(from: date as Date)
    }
    
}
