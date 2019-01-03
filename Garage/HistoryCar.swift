//
//  HistoryCar.swift
//  Garage
//
//  Created by Amjad on 21/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class HistoryCar: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var historyTableview: UITableView!
    @IBOutlet weak var carModelLabel: UILabel!
    
    @IBOutlet weak var platenmbLabel: UILabel!
    
     var HistoryData = [HistoryModel]()
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

      historyData()
        historyTableview.dataSource = self
        historyTableview.delegate = self
        historyTableview.reloadData()
    }
    
    
    
    func historyData() {
        let url = URL(string: "\(CallEngine.baseURL)\(CallEngine.HistoryApi)\(Constants.CarIDData)/\(Constants.sessions)")
        print(url)

        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)

                if let intstatus = json["Status"] as? Int {
                let status = String (intstatus)
                    if status == "1" {
                        
                   if let model = json["CarModelName"] as? String {
                    DispatchQueue.main.async {
                    self.carModelLabel.text = model
                    }
                        }
                    if let CarNoPlate = json["CarNoPlate"] as? String {
                        DispatchQueue.main.async {
                        self.platenmbLabel.text = CarNoPlate
                        }
                        }
                    
                        
                if let history = json["OrdersList"] as? [[String: Any]] {
                    for historyorder in history {
                       print(historyorder)
                        let neworder = HistoryModel(historyorder: historyorder)
                        self.HistoryData.append(neworder!)
                        
                          }
                    
                      }
                        DispatchQueue.main.async {
                            self.historyTableview.reloadData()
                        }
                    }
                    
                    else {
                    //  ToastView.show(message: "Backend issue", controller: self)
                    }
                    
                    
                    
            }
                DispatchQueue.main.async {
                   

                }
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return HistoryData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         tableView.separatorColor = UIColor.gray
        return CGFloat(60)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        let serial = HistoryData[indexPath.row].Sno
        cell.SrNo.text = "\(serial!)"
        cell.Date.text = HistoryData[indexPath.row].Date
        cell.Mechanic.text = HistoryData[indexPath.row].Mechanic
      cell.Total.text = HistoryData[indexPath.row].Total
        
        cell.selectionStyle = .none
        
        return cell
            
        }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        if let parentVC = (self.parent as? ReceptionalistView) {
            let storyboard = UIStoryboard(name: "AddnewCar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "addNewCarVc") as? addNewCar
            parentVC.switchViewController(vc: vc!, showFooter: false)
            
        }
    }
    
}
