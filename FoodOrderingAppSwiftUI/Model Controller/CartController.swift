//
//  CartController.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

class CartController: ObservableObject {
    @Published var cartItems: [Cart] = []
    
    private var listener: ListenerRegistration?
    private var db = Firestore.firestore().collection("cart")
    
    func startListener(failure: @escaping (Error?) -> Void) {
        stopListener()
        
        listener = db.addSnapshotListener { (snapshot, error) in
            if let error = error {
                failure(error)
                return
            }
            
            snapshot?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let cart = Cart(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, cart: cart)
                case .modified:
                    self.onDocumentModified(change: change, cart: cart)
                case .removed:
                    self.onDocumentRemoved(change: change)
                    
                }
            })
        }
    }
    
    private func onDocumentAdded(change: DocumentChange, cart: Cart) {
        let newIndex = Int(change.newIndex)
        cartItems.insert(cart, at: newIndex)
    }
    
    private func onDocumentModified(change: DocumentChange, cart: Cart) {
        if change.newIndex == change.oldIndex {
            //Item changed but it is still in the same position
            let index = Int(change.newIndex)
            cartItems[index] = cart
            
        } else {
            //Item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            
            cartItems.remove(at: oldIndex)
            cartItems.insert(cart, at: newIndex)
            
        }
    }
    
    private func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        cartItems.remove(at: oldIndex)
        
        
    }
    
    func updateItem(_ cart: Cart, quantity: Int) {
        var _cart = cart
       // _item.isPurchased.toggle()
        _cart.quantity = quantity
        updateItemInDB(_cart)
    }
    func updateItemInDB(_ cart: Cart) {
        db.document(cart.id).updateData(Cart.modelToData(cart: cart))
    }
    
    func removeItem(_ cart: Cart) {
        db.document(cart.id).delete()
    }
    
    
    func stopListener() {
        listener?.remove()
        listener = nil
    }
    
    deinit {
        stopListener()
    }
    
}
