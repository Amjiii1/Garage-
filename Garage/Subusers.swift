//
//  Subusers.swift
//  Garage
//
//  Created by Amjad on 07/06/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Subusers: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var subusertableview: UITableView!
    
    
    
     var usersdetail = [SubuserModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        subusertableview.dataSource = self
        subusertableview.delegate = self
        usersdetails()
    }
    
    
    func  usersdetails()  {
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.subusers)\(Constants.sessions)")
        print(url)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let bay = json["SubuserList"] as? [[String: Any]] {
                    self.usersdetail.removeAll()
                    for SubUser in bay {
                        let subUser = SubuserModel(SubUser: SubUser)
                            self.usersdetail.append(subUser!)
                    }
                    
                }
                DispatchQueue.main.async {
                    self.subusertableview.reloadData()
                }
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
        
    }
        
        
    
    // Returns count of items in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersdetail.count
    }
    
    
    
    
    // Select item from tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Constants.SubUserID = usersdetail[indexPath.row].SubUserID!
        Constants.FullName = usersdetail[indexPath.row].FullName!
        NotificationCenter.default.post(name: Notification.Name("Notificationusername"), object: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubusersCell", for: indexPath) as! SubusersCell
        cell.usersNamelbl.text = usersdetail[indexPath.row].FullName
        
        
        return cell
    }
    
   
    
}
