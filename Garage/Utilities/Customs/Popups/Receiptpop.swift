//
//  Receiptpop.swift
//  Garage
//
//  Created by Amjad on 21/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.


import UIKit

class Receiptpop: UIViewController, UITableViewDelegate, UITableViewDataSource {
 var Model = [ReceiptModel]()
    //  var dummyData = ["data 0","data 1","data 2"]
    @IBOutlet weak var Totalprice: UILabel!
    @IBOutlet weak var ReceiptTableview: UITableView!
    
    
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
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return Items.Product.count
    //    return dummyData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
        
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
//
//        let Delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
//
//        }
//        Delete.backgroundColor = UIColor.red
//
//        return [Delete]
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Items.Product.remove(at: indexPath.row)
            print(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptCell", for: indexPath) as! ReceiptCell
        
    
       cell.ProductName.text = Items.Product[indexPath.row].Name
      let price = Items.Product[indexPath.row].Price
        cell.ProductPrice.text = "\(price!)"
        let qty = Items.Product[indexPath.row].Quantity
        cell.ProductQty.text =  "\(qty!)"
        totalprice = price! + totalprice
          Constants.totalprice = totalprice
      
return cell
      self.Totalprice.text = ("\(totalprice) SAR")
}
   
}
