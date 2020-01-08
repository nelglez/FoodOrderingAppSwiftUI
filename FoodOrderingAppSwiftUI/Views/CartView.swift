//
//  CartView.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @ObservedObject var cartController: CartController
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.cartController.cartItems.count != 0 ? "Items in The Cart" : "No Items in The Cart").padding([.top, .leading])
            if self.cartController.cartItems.count != 0 {
                List() {
                    
                    ForEach(self.cartController.cartItems) { cart in
                        HStack(spacing: 15) {
                            AnimatedImage(url: URL(string: cart.pic)).resizable().frame(width: 55, height: 55).cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text(cart.item)
                                Text("\(cart.quantity)")
                            }
                        }.onTapGesture {
                            UIApplication.shared.windows.last?.rootViewController?.present(self.textFieldAlertView(id: cart.id, cart: cart), animated: true, completion: nil)
                        }
                    }.onDelete { (index) in 
                        self.cartController.removeItem(self.cartController.cartItems[index.first!])
//                        self.cartController.cartItems.remove(atOffsets: index)
                    }
                    
                    
                }
            }
        }.frame(width: UIScreen.main.bounds.width - 110, height: UIScreen.main.bounds.height - 350).background(Color.white).cornerRadius(25)
    }
    
    func textFieldAlertView(id: String, cart: Cart) -> UIAlertController {
        let alert = UIAlertController(title: "Update", message: "Enter the new quanity", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Quantity"
            textField.keyboardType = .numberPad
        }
        
        
        
        let update = UIAlertAction(title: "Update", style: .default) { (_) in
            let value = alert.textFields![0].text ?? "0"
            self.cartController.updateItem(cart, quantity: Int(value) ?? 0)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(update)
        
        return alert
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartController: CartController())
    }
}
