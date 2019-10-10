//
//  UpdatesViewController.swift
//  Garage
//
//  Created by Amjad on 21/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class UpdatesViewController: UIViewController {

    
     private var newVersion: String = ""
    
    @IBOutlet weak var lbllatestversion: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            do {
                let (updateAvailable, latestVersion) = try AppInfoHelper.isUpdateAvailable()
                print("Update available: ", updateAvailable)
                DispatchQueue.main.async {
                    self.newVersion = latestVersion
                    if updateAvailable {
                        self.showUpdateDialogue()
                    }
                }
            } catch {
                print(error)
            }
        }
        self.setupUI()
        
    }
    
    private func setupUI() {
        let latestVersion = newVersion != "" ? newVersion : AppInfoHelper.getAppCurrentVersion()
        
        DispatchQueue.main.async {
            self.lbllatestversion.text = "\(LocalizedString.Version) \(latestVersion)"
         //   self.lblCurrentVersion.text = "\(LocalizedString.Version) \(AppInfoHelper.getAppCurrentVersion())"
            
           // self.logoView.layer.cornerRadius = self.logoView.frame.size.height/2.5
        }
        
    }
    
    private func showUpdateDialogue() {
        let alert = UIAlertController(title: LocalizedString.newVersionAvailable, message: LocalizedString.likeToUpdate, preferredStyle: UIAlertControllerStyle.alert)
        
        let updateButton = UIAlertAction(title: LocalizedString.Update, style: .default, handler: {(_ action: UIAlertAction) -> Void in
            AppInfoHelper.openAppStoreToUpdateApp()
        })
        let cancelButton = UIAlertAction(title: LocalizedString.Later , style: .destructive, handler: nil)
        
        alert.addAction(cancelButton)
        alert.addAction(updateButton)
        self.present(alert, animated: true, completion: nil)
    }

    
    
    @IBAction func taptoDownload(_ sender: Any) {
        
        if newVersion != "" {
            AppInfoHelper.openAppStoreToUpdateApp()
        } else {
            UIUtility.showAlertInController(title: "", message: LocalizedString.noUpdatesAvailable, viewController: self)
        }
        
        
    }
    

}
