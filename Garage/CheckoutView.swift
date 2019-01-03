//
//  CheckoutView.swift
//  Garage
//
//  Created by Amjad Ali on 6/13/18.
//  Copyright © 2018 Amjad Ali. All rights reserved.
//

import UIKit

class CheckoutView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var popContainer: UIView!
    
    @IBOutlet weak var checkoutSegment: UISegmentedControl!
    
    let WCars = [ CheckoutCars(id: 1, make: "Honda", model: "Accord", plate: "AFX-328"),
                  CheckoutCars(id: 2, make: "Honda", model: "Civic", plate: "GLV-248"),
                  CheckoutCars(id: 3, make: "Honda", model: "City", plate: "MCB-786"),
                  CheckoutCars(id: 4, make: "Honda", model: "Fit", plate: "KUT-340"),
                  CheckoutCars(id: 5, make: "Corolla", model: "Allion", plate: "GTI-098")]
    
      let cars = [ CheckoutCars(id: 1, make: "Honda", model: "Accord", plate: "AFX-328"),
                 CheckoutCars(id: 2, make: "Honda", model: "Civic", plate: "GLV-248"),
                 CheckoutCars(id: 3, make: "Honda", model: "City", plate: "MCB-786"),
                 CheckoutCars(id: 4, make: "Honda", model: "Fit", plate: "KUT-340"),
                 CheckoutCars(id: 5, make: "Corolla", model: "Allion", plate: "GTI-098"),
                 CheckoutCars(id: 6, make: "Corolla", model: "GLI", plate: "LOU-343"),
                 CheckoutCars(id: 7, make: "Corolla", model: "XLI", plate: "VGT-195"),
                 CheckoutCars(id: 8, make: "Honda", model: "Accord", plate: "NFX-328"),
                 CheckoutCars(id: 9, make: "Honda", model: "Civic", plate: "LLV-248"),
                 CheckoutCars(id: 10, make: "Honda", model: "City", plate: "OCB-786"),
                 CheckoutCars(id: 11, make: "Honda", model: "Fit", plate: "FUT-340"),
                 CheckoutCars(id: 12, make: "Corolla", model: "Allion", plate: "PTI-098"),
                 CheckoutCars(id: 13, make: "Corolla", model: "GLI", plate: "HOU-343"),
                 CheckoutCars(id: 14, make: "Corolla", model: "XLI", plate: "FGT-195"),
                 CheckoutCars(id: 15, make: "Honda", model: "Accord", plate: "AFX-328"),
                 CheckoutCars(id: 16, make: "Honda", model: "Civic", plate: "GLV-248"),
                 CheckoutCars(id: 17, make: "Honda", model: "City", plate: "MCB-786"),
                 CheckoutCars(id: 18, make: "Honda", model: "Fit", plate: "KUT-340"),
                 CheckoutCars(id: 19, make: "Corolla", model: "Allion", plate: "GTI-098"),
                 CheckoutCars(id: 20, make: "Corolla", model: "GLI", plate: "LOU-343"), ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContainer.dataSource = self
        tableViewContainer.delegate = self
      
    }
    
    
    
    @IBAction func segmentAction(_ sender: Any) {
        tableViewContainer.reloadData()
    }
    
    
    
    
    
    @IBAction func unwindToViewController1(segue : UIStoryboardSegue) {
        //you will get control back here when you unwind
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (checkoutSegment.selectedSegmentIndex) {
        case 0:
            returnValue = WCars.count
        case 1:
            returnValue = cars.count
        case 2:
            returnValue = WCars.count
        default:
            break
        }
        
        return returnValue
    }
        
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StaticCheckoutCell", for: indexPath)
           
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCell
            
            
            
            switch (checkoutSegment.selectedSegmentIndex) {
            case 0:
                let Inwork = WCars[indexPath.row - 1]
                cell.populate(with: Inwork)
            case 1:
                let hold = cars[indexPath.row]
                cell.populate(with: hold)
            case 2:
                let wcar = WCars[indexPath.row]
                cell.populate(with: wcar)
            default:
                break
            }
             cell.selectionStyle = .none
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         tableView.separatorColor = UIColor.darkGray
        return CGFloat(60)
        
    }
    
    
    @IBAction func checkOutViewAction(_ sender: Any) {
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "CheckoutPopUp", bundle: nil)
            let setting = storyboard.instantiateViewController(withIdentifier: "CheckOutPopVc") as! CheckOutPopView
            let navigationController = UINavigationController(rootViewController: setting)
            navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            parentVC.switchViewController(vc: setting, showFooter: false)
    }
    
    }
    
    
    @IBAction func settings(_ sender: Any) {
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
            let setting = storyboard.instantiateViewController(withIdentifier: "SettingViewControllerVc") as! SettingsViewController
            parentVC.switchViewController(vc: setting, showFooter: false)
        
    }
    }
    
    
    
    
    func setupConstraints(){
       

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
