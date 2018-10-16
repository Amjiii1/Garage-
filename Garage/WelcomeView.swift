//
//  WelcomeView.swift
//  Garage
//
//  Created by Amjad Ali on 7/9/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    @IBOutlet var welcomeView: UIView!
    
    @IBOutlet weak var carSearchTextField: UITextField!
    
    @IBOutlet weak var WelcomeSegmented: UISegmentedControl!
    @IBOutlet weak var tableViewWelcome: UITableView!
    
    let cars = [ Car(id: 1, make: "Honda", model: "Accord", plate: "AFX-328"),
                 Car(id: 2, make: "Honda", model: "Civic", plate: "GLV-248"),
                 Car(id: 3, make: "Honda", model: "City", plate: "MCB-786"),
                 Car(id: 4, make: "Honda", model: "Fit", plate: "KUT-340"),
                 Car(id: 5, make: "Corolla", model: "Allion", plate: "GTI-098"),
                 Car(id: 6, make: "Corolla", model: "GLI", plate: "LOU-343"),
                 Car(id: 7, make: "Corolla", model: "XLI", plate: "VGT-195"),
                 Car(id: 8, make: "Honda", model: "Accord", plate: "NFX-328"),
                 Car(id: 9, make: "Honda", model: "Civic", plate: "LLV-248"),
                 Car(id: 10, make: "Honda", model: "City", plate: "OCB-786"),
                 Car(id: 11, make: "Honda", model: "Fit", plate: "FUT-340"),
                 Car(id: 12, make: "Corolla", model: "Allion", plate: "PTI-098"),
                 Car(id: 13, make: "Corolla", model: "GLI", plate: "HOU-343"),
                 Car(id: 14, make: "Corolla", model: "XLI", plate: "FGT-195"),
                 Car(id: 15, make: "Honda", model: "Accord", plate: "AFX-328"),
                 Car(id: 16, make: "Honda", model: "Civic", plate: "GLV-248"),
                 Car(id: 17, make: "Honda", model: "City", plate: "MCB-786"),
                 Car(id: 18, make: "Honda", model: "Fit", plate: "KUT-340"),
                 Car(id: 19, make: "Corolla", model: "Allion", plate: "GTI-098"),
                 Car(id: 20, make: "Corolla", model: "GLI", plate: "LOU-343"), ]
    let WCars = [ Car(id: 1, make: "Honda", model: "Accord", plate: "AFX-328"),
                 Car(id: 2, make: "Honda", model: "Civic", plate: "GLV-248"),
                 Car(id: 3, make: "Honda", model: "City", plate: "MCB-786"),
                 Car(id: 4, make: "Honda", model: "Fit", plate: "KUT-340"),
                 Car(id: 5, make: "Corolla", model: "Allion", plate: "GTI-098")]
    
    var Welcomecellobj = [WelcomeModel]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewWelcome.dataSource = self
        tableViewWelcome.delegate = self
       tableViewWelcome.reloadData()
       

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = self.parent as? ReceptionalistView {
            vc.addFooterView1(selected: 0)
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        if let vc = self.parent as? ReceptionalistView {
//            vc.removeFooterView()
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (WelcomeSegmented.selectedSegmentIndex) {
        case 0:
            returnValue = cars.count
        case 1:
            tableView.backgroundColor = .red
        case 2:
           tableView.backgroundColor = .red
        default:
            break
        }
        return returnValue
    }
        
    
   
      func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let Cancel = UITableViewRowAction(style: .normal, title: "Cancel") { action, index in
           
        }
        Cancel.backgroundColor = UIColor.black
        
        
        return [Cancel]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "StaticCell", for: indexPath)
           
            return cell
            
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "welcomeCell", for: indexPath) as! Welcomecell
      //  cell.selectionStyle = .none
                    let car = cars[indexPath.row - 1]
            
            cell.populate(with: car)
            
            return cell
        
    }
        
    }
    
    
    @IBAction func carScannerBtn(_ sender: Any) {
        if let vc = self.parent as? ReceptionalistView {
                let storyboard = UIStoryboard(name: "CarScan", bundle: nil)
                let carScanner = storyboard.instantiateViewController(withIdentifier: "carScannerVc") as!CarScannerView
                vc.switchViewController(vc: carScanner, showFooter: false)
    
        }
    }
    
    @IBAction func addNewCarBtn(_ sender: Any) {
        if let vc = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let newCarvc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as! addNewCar
            vc.switchViewController(vc: newCarvc, showFooter: false)
        }
    }
    
    
   
 }


