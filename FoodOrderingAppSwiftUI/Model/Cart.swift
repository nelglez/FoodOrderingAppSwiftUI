//
//  Cart.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Cart: Identifiable {
    var id: String
    var item: String
    var quantity: Int
    var quickDelivery: Bool
    var cashOnDelivery: Bool
    var pic: String
    
    init(id: String = "", item: String = "", quantity: Int = 0, quickDelivery: Bool = false, cashOnDelivery: Bool = false, pic: String = "") {
        self.id = id
        self.item = item
        self.quantity = quantity
        self.quickDelivery = quickDelivery
        self.cashOnDelivery = cashOnDelivery
        self.pic = pic
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        item = data["item"] as? String ?? ""
        quantity = data["quantity"] as? Int ?? 0
        quickDelivery = data["quick_delivery"] as? Bool ?? false
        cashOnDelivery = data["cash_on_delivery"] as? Bool ?? false
        pic = data["pic"] as? String ?? ""
    }
    
    static func modelToData(cart: Cart) -> [String: Any] {
        let data: [String: Any] = [
            "id": cart.id,
            "item": cart.item,
            "quantity": cart.quantity,
            "quick_delivery": cart.quickDelivery,
            "cash_on_delivery": cart.cashOnDelivery,
            "pic": cart.pic
        ]
        
        return data
    }
}
