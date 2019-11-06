//
//  LanguageViewController.swift
//  Garage
//
//  Created by Amjad on 21/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    
    @IBOutlet weak var languageController: UISegmentedControl!
    
    
    
    
    //Localization
    
    let restart = NSLocalizedString("restart", comment: "")
    
    
    //Localization
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
         Constants.language = UserDefaults.standard.integer(forKey: Constants.savelang)
    languageController.selectedSegmentIndex = Constants.language
        // Do any additional setup after loading the view.
    }
    

   

    
    @IBAction func languageSwitch(_ sender: Any) {
        
        switch languageController.selectedSegmentIndex
        {
        case 0:
                L102Language.setAppleLAnguageTo(lang: "en")
            UserDefaults.standard.set(languageController.selectedSegmentIndex, forKey: Constants.savelang)
        case 1:
                L102Language.setAppleLAnguageTo(lang: "ar")
             UserDefaults.standard.set(languageController.selectedSegmentIndex, forKey: Constants.savelang)
        default:
            break
        }
        self.alert(view: self, title: LocalizedString.Alert, message: restart)
    }
    
    
    
    
    func alert(view: LanguageViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            Constants.language = UserDefaults.standard.integer(forKey: Constants.savelang)
         //  exit(0)
        })
        
        alert.addAction(defaultAction)
       
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    
    
    
}
