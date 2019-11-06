//
//  SubuserAssist.swift
//  Garage
//
//  Created by Amjad on 08/03/1441 AH.
//  Copyright © 1441 Amjad Ali. All rights reserved.
//

import UIKit

class SubuserAssist: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    
    
    
    @IBOutlet weak var AssistantTable: UITableView!
    
    
    var usersdetail = [SubuserModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        AssistantTable.dataSource = self
        AssistantTable.delegate = self
        usersdetails()
    }
    
    
    func  usersdetails()  {
        
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.subusers)\(Constants.sessions)")
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
                    self.AssistantTable.reloadData()
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
        
        Constants.SubUserIDAssist = usersdetail[indexPath.row].SubUserID ?? 0
        Constants.FullNameAsis = usersdetail[indexPath.row].FullName ?? ""
        NotificationCenter.default.post(name: Notification.Name("NotificationusernameAsist"), object: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubuserAssistCell", for: indexPath) as! SubuserAssistCell
        cell.AssistantName.text = usersdetail[indexPath.row].FullName
        
        
        return cell
    }
    
    
    
}
