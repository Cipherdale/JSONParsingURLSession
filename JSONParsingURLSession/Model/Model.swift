//
//  Model.swift
//  JSONParsingURLSession
//
//  Created by Andrian Rahardja on 04/01/18.
//  Copyright © 2018 episquare. All rights reserved.
//

import Foundation

struct MainList {
    let categoryName: String
    let categoryItems: [Items]
}



struct Items {
    let itemId: Int
    let itemBrand: String
    let itemName: String
    let itemDescription: String
    let itemPrice: String
    let itemImageUrl: String
    
    init(dictionary: [String: Any]) {
        
        self.itemId = dictionary["id"] as? Int ?? 0
        self.itemBrand = dictionary["brand"] as? String ?? "Unknown item brand"
        self.itemName = dictionary["name"] as? String ?? "Unknown item name"
        self.itemDescription = dictionary["description"] as? String ?? "Unknown item description"
        self.itemPrice = dictionary["price"] as? String ?? "Unknown item price"
        self.itemImageUrl = dictionary["image_url"] as? String ?? "Unknown item image_url"
    }
}
