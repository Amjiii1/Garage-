//
//  AboutusViewController.swift
//  Garage
//
//  Created by Amjad on 21/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class AboutusViewController: UIViewController {
    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var versionLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLbl.text = Constants.Currentversion
   
        
//        mainView.layer.shadowColor = UIColor.black.cgColor
//        mainView.layer.shadowOpacity = 1
//        mainView.layer.shadowOffset = .zero
//        mainView.layer.shadowRadius = 14
//        mainView.layer.shadowPath = UIBezierPath(rect: mainView.bounds).cgPath
   //     mainView.layer.shouldRasterize = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
