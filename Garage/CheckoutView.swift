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
    
    
    let WCars = [ CheckoutCars(id: 1, make: "Honda", model: "Accord", plate: "AFX-328", Cbay: "B1"),
                  CheckoutCars(id: 2, make: "Honda", model: "Civic", plate: "GLV-248", Cbay: "B2"),
                  CheckoutCars(id: 3, make: "Honda", model: "City", plate: "MCB-786", Cbay: "B3"),
                  CheckoutCars(id: 4, make: "Honda", model: "Fit", plate: "KUT-340", Cbay: "B4"),
                  CheckoutCars(id: 5, make: "Corolla", model: "Allion", plate: "GTI-098", Cbay: "B5")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContainer.dataSource = self
        tableViewContainer.delegate = self
        tableViewContainer.reloadData()
      
    }
    
    @IBAction func unwindToViewController1(segue : UIStoryboardSegue) {
        //you will get control back here when you unwind
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return WCars.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StaticCheckoutCell", for: indexPath)
           
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutCell
            
             
            let CheckoutCars = WCars[indexPath.row - 1]
            
            cell.populate(with: CheckoutCars)
            
            return cell
            
        }
    }
    
    
   
    
    
    @IBAction func ChecoutTest(_ sender: Any) {
        
        if let parentVC = self.parent as? ReceptionalistView {
            let storyboard = UIStoryboard(name: "CheckoutPopUp", bundle: nil)
            let setting = storyboard.instantiateViewController(withIdentifier: "CheckOutPopVc") as! CheckOutPopView
            parentVC.switchViewController(vc: setting, showFooter: false)
            
        }
        
        
        
        
//        if let vc = self.parent as? CheckoutView {
//        let storyboard = UIStoryboard(name: "CheckoutPopUp", bundle: nil)
//        let Checkout = storyboard.instantiateViewController(withIdentifier: "CheckOutPopVc") as! CheckOutPopView
//           // vc.splitViewController(vc: Checkout, showFooter: false)
//
//        addChildViewController(Checkout)
//        view.addSubview(Checkout.view)
//        Checkout.didMove(toParentViewController: self)
        
      //  addChildViewController(Checkout)
        //self.present(Checkout, animated: true, completion: nil)
//        if let vc = UIApplication.shared.keyWindow?.rootViewController {
//            Checkout.view.frame = vc.view.frame
//            vc.addChildViewController(Checkout)
//            vc.view.addSubview(Checkout.view)
     //  }
    }
    
    
    
    func setupConstraints(){
       

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
