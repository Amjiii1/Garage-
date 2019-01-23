////
////  CheckCarTableviewController.swift
////  Garage
////
////  Created by Amjad on 20/04/1440 AH.
////  Copyright © 1440 Amjad Ali. All rights reserved.
////
//
//import UIKit
//
//
//struct Headline {
//    
//    var id : Int
//    var date : Date
//    var title : String
//    var text : String
//    var image : String
//}
//
//
//fileprivate func parseDate(_ str : String) -> Date {
//    let dateFormat = DateFormatter()
//    dateFormat.dateFormat = "yyyy-MM-dd"
//    return dateFormat.date(from: str)!
//}
//
//fileprivate func firstDayOfMonth(date : Date) -> Date {
//    let calendar = Calendar.current
//    let components = calendar.dateComponents([.year, .month], from: date)
//    return calendar.date(from: components)!
//}
//
//class CheckCarTableviewController: UITableViewController {
//    
//    
//    @IBOutlet var checklistTableview: UITableView!
//    
//    let  Sections: [String] = ["Section 1", "Section 2", "Section 3"]
//    let SectionImage: [UIImage] = [#imageLiteral(resourceName: <#T##String#>),]
//   
//    
//    var sections = [TableSection<Date, Headline>]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.sections = TableSection.group(rowItems: self.headlines, by: { (headline) in
//            return firstDayOfMonth(date: headline.date)
//        })
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return self.sections.count
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//      return "Section \(Items)"
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let section = self.sections[section]
//        return section.rowItems.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Label1Cell", for: indexPath)
//        
//        let section = self.sections[indexPath.section]
//        let headline = section.rowItems[indexPath.row]
//        cell.textLabel?.text = headline.title
//       // cell.detailTextLabel?.text = headline.text
//       // cell.imageView?.image = UIImage(named: headline.image)
//        
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.separatorColor = UIColor.darkGray
//        return CGFloat(60)
//        
//    }
//    
//    
//
//  
//
//}
