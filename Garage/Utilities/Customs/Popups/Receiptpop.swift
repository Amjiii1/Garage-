//
//  Receiptpop.swift
//  Garage
//
//  Created by Amjad on 21/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.


import UIKit



let NotifyPrice = "\(Constants.totalprice)"


class Receiptpop: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var Model = [ReceiptModel]()
    //  var dummyData = ["data 0","data 1","data 2"]
    @IBOutlet weak var Totalprice: UILabel!
    @IBOutlet weak var ReceiptTableview: UITableView!
    
    @IBOutlet weak var OrderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var totalprice = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        ReceiptTableview.dataSource = self
        ReceiptTableview.delegate = self
        ReceiptTableview.reloadData()
        print("hello")
        self.Totalprice.text = ("\(Constants.totalprice) SAR")
        ReceiptTableview.separatorStyle = .none
        dataupdate()
    }
    
    func dataupdate() {
    
     if Constants.flagEdit != 0 || Constants.editcheckout != 0  {
        OrderLabel.text = "\(Constants.OrderIDData)"
        statusLabel.text = "Hold"
        }
     else {
        
        OrderLabel.text = "0"
        statusLabel.text = "new"
        
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Items.Product.count
        //    return dummyData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let Delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            if Constants.flagEdit != 0  || Constants.editcheckout != 0 {
                 let Model = Items.Product[indexpath.row]
                Model.Mode = "Delete"
                Model.Status = 203
                print( Constants.totalprice)
             Items.nameArray.append(Model)
            }
             let prc = Items.Product[indexpath.row]
              Constants.totalprice = Constants.totalprice - prc.Price!
                   Items.Product.remove(at: indexpath.row)
            self.ReceiptTableview.deleteRows(at: [indexpath], with: .automatic)
          self.Totalprice.text = ("\(Constants.totalprice) SAR")
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        }
        
        Delete.backgroundColor = UIColor.red
        
        return [Delete]
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptCell", for: indexPath) as! ReceiptCell
        
        
        cell.ProductName.text = Items.Product[indexPath.row].Name
        let qty = Items.Product[indexPath.row].Quantity
        cell.ProductPrice.text = "\(qty!)"
        let price = Items.Product[indexPath.row].Price
        cell.ProductQty.text =  "\(price!)"
        
        
        //        totalprice = price! + totalprice
        //          Constants.totalprice = totalprice
        //           print(Constants.totalprice)
        //       self.Totalprice.text = ("\(Constants.totalprice) SAR")
        return cell
        
    }
    
}
