//
//  profilePOpViewController.swift
//  Garage
//
//  Created by Amjad on 20/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class profilePOpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profiletableview: UITableView!
    
    let names = ["Amjad","Rafi","bilal"]
    let titles = ["Manager","Mechanic","Mechanic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.isNavigationBarHidden = true
        profiletableview.dataSource = self
        profiletableview.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilecell", for: indexPath) as! ProfileCell
        cell.userImage.image = UIImage(named: (names [indexPath.row] + ".jpg"  ))
        cell.labelName.text = names [indexPath.row]
        cell.title.text = titles [indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Company Name : " + names[indexPath.row])
        
        Shared.shared.companyName = names[indexPath.row]
        //        let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        //        let newViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewControllerVc") as! SettingsViewController
        //        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    



}
