//
//  Mechanicpop.swift
//  Garage
//
//  Created by Amjad on 19/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Mechanicpop: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var mechanicTableview: UITableView!
    
      var Details = [Orderdetail]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        mechanicTableview.dataSource = self
        mechanicTableview.delegate = self
       
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    
    // Select item from tableView
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
        //MechanicModel
    }
    
    //Assign values for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MechanicpopCell", for: indexPath) as! MechanicpopCell
       
//        cell.DataLbl.text = Details[indexPath.row].
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
   
}
