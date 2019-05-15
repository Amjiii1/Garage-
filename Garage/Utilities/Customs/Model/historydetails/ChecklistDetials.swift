//
//  ChecklistDetials.swift
//  Garage
//
//  Created by Amjad on 04/09/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class ChecklistDetials: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var checklistTbl: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checklistTbl.allowsMultipleSelection = true
        self.checklistTbl.allowsMultipleSelectionDuringEditing = true
        checklistTbl.delegate = self
        checklistTbl.dataSource = self
        checklistTbl.separatorStyle = .none
    }
    
    
  
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.white
        return CGFloat(40)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistoryDetails.SaveInspectionDtail.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "checklist", for: indexPath) as? HistoryChecklist else { return UITableViewCell() }
        
       // cell.titleLabels.text = HistoryDetails.SaveInspectionDtail[indexPath.row].Name
      cell.Titlelabel.text = HistoryDetails.SaveInspectionDtail[indexPath.row].Name
        cell.valuelabel.text = HistoryDetails.SaveInspectionDtail[indexPath.row].Value
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return HistoryDetails.SaveInspectionlist[section].NameH
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HistoryDetails.SaveInspectionlist.count
    }
    
    

}
