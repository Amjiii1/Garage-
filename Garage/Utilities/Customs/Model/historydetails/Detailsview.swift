//
//  Detailsview.swift
//  Garage
//
//  Created by Amjad on 04/09/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class Detailsview: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var orderdetailtable: UITableView!
    
    @IBOutlet weak var totalpricetable: UITableView!
    
    @IBOutlet weak var grandtotallabel: UILabel!
    
    
    
    var dummyData2 = ["SubTotal","Discount","VAT 5%"]
    var amount2 = [Constants.subtotal,0.00,Constants.checkouttax]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderdetailtable.delegate = self
        orderdetailtable.dataSource = self
        totalpricetable.delegate = self
        totalpricetable.dataSource = self
       
        orderdetailtable.separatorStyle = .none
        totalpricetable.separatorStyle = .none
        grandtotallabel.text = String(format: "%.2f", Constants.checkoutGrandtotal)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnvalue = 0
        if tableView == orderdetailtable {
            returnvalue = HistoryDetails.savedetail.count
        }
        else if tableView == totalpricetable {
            returnvalue = 3
        }
        return returnvalue
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == orderdetailtable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! orderdetailCell
            let name = HistoryDetails.savedetail[indexPath.row].Name
            let qty = HistoryDetails.savedetail[indexPath.row].Quantity
            cell.labelItem.text = "\(qty!) x \(name!)"
         
            let price = HistoryDetails.savedetail[indexPath.row].Price
            cell.labelPrice.text =  "\(price!)"
            cell.selectionStyle = .none
            return cell
        }
        else if tableView == totalpricetable {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! totalpriceCell
            cell2.labelTitle.text = dummyData2[indexPath.row]
            let tax = amount2[indexPath.row]
             cell2.labeltotal.text = String(format: "%.2f", tax)//String(tax)
            cell2.selectionStyle = .none
            return cell2
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.gray
        return CGFloat(40)
        
    }
    

   

}
