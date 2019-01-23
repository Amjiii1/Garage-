//
//  PopOver.swift
//  Garage
//
//  Created by Amjad  on 17/01/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class PopOver: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablviepopover: UITableView!
    
    
   // var names: [String] = ["B1","B2","B3","B4","B5","Waiting list"]
    var Baydetails = [popModel]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tablviepopover.dataSource = self
        tablviepopover.delegate = self
        
        // Apply radius to Popupview
//        Popupview.layer.cornerRadius = 10
//        Popupview.layer.masksToBounds = true
         baylist() 
    }
    
    
    
    
    
    func  baylist()  {
        
        
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.BayAssignApi)\(Constants.sessions)")
        print(url)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let bay = json["BaysList"] as? [[String: Any]] {
                    self.Baydetails.removeAll()
                    for Baylist in bay {
                    
                        print(Constants.bayflag)
                        let baylist = popModel(Baylist: Baylist)
                        if Constants.bayflag == 1 {
                            let new = baylist?.Name
                            let new1 = baylist?.BayID
                        if (new == "Waiting List") && (new1 == 0)   {
                            print("Hello world")
                        } else {
                        self.Baydetails.append(baylist!)
                        }
                            
                        } else {
                             self.Baydetails.append(baylist!)
                            
                        }
                        
                    }
                    
                }
                DispatchQueue.main.async {
                    self.tablviepopover.reloadData()
                    Constants.bayflag = 0
                }
                
            } catch let error as NSError {
                print(error)
                Constants.bayflag = 0
            }
        }).resume()
//        DispatchQueue.main.async {
//          self.tablviepopover.reloadData()
//            
//            
//        }
        
       
        
    }
    
    
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return Baydetails.count
    }
    
    
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Constants.bayid = Baydetails[indexPath.row].BayID!
        Constants.bayname = Baydetails[indexPath.row].Name!
        NotificationCenter.default.post(name: Notification.Name("Notificationbayname"), object: nil)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        dismiss(animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
        
    }
   
    //Assign values for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popcell", for: indexPath) as! popcell
        cell.bayLabel.text = Baydetails[indexPath.row].Name
        
        
        return cell
    }
    
    // Close PopUp
  
}

    
    
    
    
    
    
    
    
    


