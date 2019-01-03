//
//  CheckCarTableviewController.swift
//  Garage
//
//  Created by Amjad on 20/04/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit


struct Headline {
    
    var id : Int
    var date : Date
    var title : String
    var text : String
    var image : String
    
}

fileprivate func parseDate(_ str : String) -> Date {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    return dateFormat.date(from: str)!
}

fileprivate func firstDayOfMonth(date : Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
}

class CheckCarTableviewController: UITableViewController {
    var headlines = [
        Headline(id: 1, date: parseDate("2018-02-15"), title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc in ipsum vehicula accumsan quis sit amet quam. Sed vel feugiat eros.", image: "filter"),
        Headline(id: 2, date: parseDate("2018-03-05"), title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id ornare tortor, quis dictum enim. Morbi convallis tincidunt quam eget bibendum. Suspendisse malesuada maximus ante, at molestie massa fringilla id.", image: "filter"),
        Headline(id: 3, date: parseDate("2018-02-10"), title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non, finibus et diam. Morbi et felis a lacus pharetra blandit.", image: "Banana"),
        Headline(id: 4, date: parseDate("2018-05-15"), title: "Proin suscipit maximus", text: "Quisque ultrices odio in neque eleifend eleifend. Praesent tincidunt euismod sem, et rhoncus lorem facilisis eget.", image: "filter"),
        ]
    
    var sections = [TableSection<Date, Headline>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sections = TableSection.group(rowItems: self.headlines, by: { (headline) in
            return firstDayOfMonth(date: headline.date)
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        let date = section.sectionItem
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.rowItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Label1Cell", for: indexPath)
        
        let section = self.sections[indexPath.section]
        let headline = section.rowItems[indexPath.row]
        cell.textLabel?.text = headline.title
       // cell.detailTextLabel?.text = headline.text
        cell.imageView?.image = UIImage(named: headline.image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.separatorColor = UIColor.darkGray
        return CGFloat(60)
        
    }
    

  

}
