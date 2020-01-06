//
//  Category.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Categories: Identifiable {
    var id: String
    var name: String
    var price: String
    var pic: String
    
    init(id: String = "", name: String = "", price: String = "", pic: String = "") {
        self.id = id
        self.name = name
        self.price = price
        self.pic = pic
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        name = data["name"] as? String ?? ""
        price = data["price"] as? String ?? ""
        pic = data["pic"] as? String ?? ""
    }
    
    static func modelToData(cat: Categories) -> [String: Any] {
        let data: [String: Any] = [
            "id": cat.id,
            "name": cat.name,
            "price": cat.price,
            "pic": cat.pic
        ]
        
        return data
    }
}
