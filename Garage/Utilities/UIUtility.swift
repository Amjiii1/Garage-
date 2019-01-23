//
//  UIUtility.swift
//  Garage
//
//  Created by Amjad on 15/05/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit



enum AlertTitle: String {
    case Success
    case Error
    case Info
}


class UIUtility: NSObject {
 
    static func showNoInternetAlert() {
        showAlert(title: "Please check your internet")
    }
    
    static func showAlert(title: String, heading: AlertTitle = AlertTitle.Error) {
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: heading.rawValue, message: title, preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//                alert.dismiss(animated: true, completion: nil)
//            }
//            alert.addAction(okAction)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.navigationVC?.present(alert, animated: true, completion: nil)
//        }
    }

}
