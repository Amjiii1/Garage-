//
//  ModelProduct.swift
//  Garage
//
//  Created by Amjad on 22/02/1440 AH.
//  Copyright © 1440 Amjad Ali. All rights reserved.
//

import Foundation

struct Category {
    
    let subCategories: [SubCategory]
    let categoryID: Int
    let name: String
    let alternateName: String
    let desc: String
    let image: String
    let status: Int
    let displayOrder: Int
    let lastUpdatedDate: String
}

struct SubCategory {
    
    let items: [Item]
    let Searchitems: [Item]
    let categoryID: Int
    let subCategoryID: Int
    let name: String
    let alternateName: String
    let desc: String
    let image: String
    let status: Int
    let displayOrder: Int
    let lastUpdatedDate: String
}

struct Item {
    
    let itemID: Int
    let name: String
    let alternateName: String
    let desc: String
    let price: Double
    let image: String
    let barcode: String
    let itemType: String
    let status: Int
    let lastUpdatedDate: String
    let displayOrder: Int
    let categoryID: Int
    let subCategoryID: Int
    let modifiers: [Modifier]
}

struct Modifier {
    
    let title: String
    let subTitle: String
}
