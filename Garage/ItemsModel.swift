//
//  ItemsModel.swift
//  Garage
//
//  Created by Amjad on 13/08/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import UIKit

class ItemsModel: NSObject {

    var ItemID: Int?
    var Name: String?
    var AlternateName: String?
    var Desc: String?
    var Price: Double?
    var Image: String?
    var Barcode: String?
    var ItemType: String?
    var Status: Int?
    var LastUpdatedDate: String?
    var DisplayOrder: Int?
    var CategoryID: Int?
    var SubCategoryID: Int?
    
    
    
    
    override init() {
        
    }
    
    
    init(ItemID: Int, Name: String, AlternateName: String, Desc: String, Price: Double, Image: String, Barcode: String, ItemType: String, Status: Int, LastUpdatedDate: String, DisplayOrder: Int, CategoryID: Int, SubCategoryID: Int) {
        
        self.ItemID = ItemID
        self.Name = Name
        self.AlternateName = AlternateName
        self.Desc = Desc
        self.Price = Price
        self.Image = Image
        self.Barcode = Barcode
        self.ItemType = ItemType
        self.Status = Status
        self.LastUpdatedDate = LastUpdatedDate
        self.DisplayOrder = DisplayOrder
        self.CategoryID = CategoryID
        self.SubCategoryID = SubCategoryID
       
    }
    
    init?(ProductModel: [String: Any]){

        guard let itemID = ProductModel["ItemID"] as? Int,
            let name = ProductModel["Name"] as? String,
            let alternateName = ProductModel["AlternateName"] as? String,
            let desc = ProductModel["Desc"] as? String,
            let price = ProductModel["Price"] as? Double,
    
            let image = ProductModel["Image"] as? String,
            let barcode = ProductModel["Barcode"] as? String,
            let itemType = ProductModel["ItemType"] as? String,
            let status = ProductModel["Status"] as? Int,
            let lastUpdatedDate = ProductModel["LastUpdatedDate"] as? String,
            let displayOrder = ProductModel["DisplayOrder"] as? Int,
            let categoryID = ProductModel["CategoryID"] as? Int,
            let subCategoryID = ProductModel["SubCategoryID"] as? Int

        
        else{return}
        
        self.ItemID = itemID
        self.Name = name
        self.AlternateName = alternateName
        self.Desc = desc
        self.Price = price
    
    
        self.Image = image
        self.Barcode = barcode
        self.ItemType = itemType
        self.Status = status
        self.LastUpdatedDate = lastUpdatedDate
        self.DisplayOrder = displayOrder
        self.CategoryID = categoryID
         self.SubCategoryID = subCategoryID
        
        
    
    
    
}
    
}
