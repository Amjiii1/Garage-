//
//  SearchResultsController.swift
//  Garage
//
//  Created by Amjad on 11/08/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    
    var dumi = ["hello", "Sign", "zindagi"]
    var marrCountryList = [String]()
    var marrFilteredCountryList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marrCountryList = ["USA", "Bahamas", "Brazil", "Canada", "Republic of China", "Cuba", "Egypt", "Fiji", "France", "Germany", "Iceland", "India", "Indonesia", "Jamaica", "Kenya", "Madagascar", "Mexico", "Nepal", "Oman", "Pakistan", "Poland", "Singapore", "Somalia", "Switzerland", "Turkey", "UAE", "Vatican City"]
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.marrFilteredCountryList.count
        } else {
            return self.marrCountryList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath as IndexPath)
        
        var countryName : String!
        if tableView == self.searchDisplayController!.searchResultsTableView {
            cell.textLabel?.text = marrFilteredCountryList[indexPath.row]
        } else {
             cell.textLabel?.text = marrCountryList[indexPath.row]
        }
        
                return cell
        
    }
    
    func filterTableViewForEnterText(searchText: String) {
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
        
        let array = (self.marrCountryList as NSArray).filtered(using: searchPredicate)
        self.marrFilteredCountryList = array as! [String]
        self.tableView.reloadData()
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        self.filterTableViewForEnterText(searchText: searchString!)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController,
                                 shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterTableViewForEnterText(searchText: self.searchDisplayController!.searchBar.text!)
        return true
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//       return self.dumi.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
//        cell.textLabel?.text = self.dumi[indexPath.row]
//        return cell
//    }
//
//     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        print("Hello world")
//
//        }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
