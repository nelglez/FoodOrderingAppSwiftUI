//
//  CategoriesController.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

class CategoriesController: ObservableObject {
    @Published var categories: [Categories] = []
    
    private var listener: ListenerRegistration?
    private var db = Firestore.firestore().collection("categories")
    private var docRef: DocumentReference!
        
        func startListener(failure: @escaping (Error?) -> Void) {
            stopListener()
            
            listener = db.addSnapshotListener { (snapshot, error) in
                    if let error = error {
                        failure(error)
                        return
                    }
                    
                    snapshot?.documentChanges.forEach({ (change) in
                    let data = change.document.data()
                    let category = Categories(data: data)
   
                       switch change.type {
                       case .added:
                           self.onDocumentAdded(change: change, cat: category)
                       case .modified:
                           self.onDocumentModified(change: change, cat: category)
                       case .removed:
                           self.onDocumentRemoved(change: change)
                           
                       }
                        })
            }
        }
        
        private func onDocumentAdded(change: DocumentChange, cat: Categories) {
            let newIndex = Int(change.newIndex)
            categories.insert(cat, at: newIndex)
            
        }
        
        private func onDocumentModified(change: DocumentChange, cat: Categories) {
            if change.newIndex == change.oldIndex {
                //Item changed but it is still in the same position
                let index = Int(change.newIndex)
                categories[index] = cat
                
            } else {
                //Item changed and changed position
                let oldIndex = Int(change.oldIndex)
                let newIndex = Int(change.newIndex)
                
                categories.remove(at: oldIndex)
                categories.insert(cat, at: newIndex)
                
            }
        }
        
        private func onDocumentRemoved(change: DocumentChange) {
            let oldIndex = Int(change.oldIndex)
            categories.remove(at: oldIndex)
            
            
        }
    
    func addItem(item: String, quantity: Int, quickDelivery: Bool, cashOnDelivery: Bool, pic: String, completion: @escaping (Error?) -> Void) {
        var cart = Cart(id: "", item: item, quantity: quantity, quickDelivery: quickDelivery, cashOnDelivery: cashOnDelivery, pic: pic)
        docRef = Firestore.firestore().collection("cart").document() //add new document
        cart.id = docRef.documentID
        
        let data = Cart.modelToData(cart: cart)
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
                return
            }
            completion(nil)
        }
        
        
       }
       
    
    func stopListener() {
           listener?.remove()
           listener = nil
       }
       
       deinit {
           stopListener()
       }
        
    
//    init() {
//        let db = Firestore.firestore()
//        db.collection("categories").addSnapshotListener { (snap, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            for i in snap!.documentChanges {
//                let id = i.document.documentID
//                let name = i.document.get("name") as! String
//                let price = i.document.get("price") as! String
//                let pic = i.document.get("pic") as! String
//
//                self.categories.append(Categories(id: id, name: name, price: price, pic: pic))
//
//            }
//        }
//    }
}
