//
//  AFWrapperClass.swift
//  Garage
//
//  Created by Amjad on 19/03/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class AFWrapperClass: NSObject {
    
    class func compareStringValue(currentValue:String, limit:Int, toDo : mathFunction) -> String {
        var current : Int = Int(currentValue)!
        if (current <= limit) && (current >= 0) {
            if toDo == .Add {
                if current == limit {
                    return String(current)
                }
                else{
                    current += 1
                    return String(current)
                }
            }
            else {
                if current == 0 {
                    return String(current)
                }
                else {
                    current -= 1
                    return String(current)
                }
            }
        }
        else {
            return String(current)
        }
        
        
        
        
     
    }
    
    
}


