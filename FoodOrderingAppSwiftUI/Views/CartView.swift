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
    @ObservedObject var cartController = CartController()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.cartController.cartItems.count != 0 ? "Items in The Cart" : "No Items in The Cart").padding([.top, .leading])
            if self.cartController.cartItems.count != 0 {
                List(self.cartController.cartItems) { cart in
                    HStack(spacing: 15) {
                        AnimatedImage(url: URL(string: cart.pic)).resizable().frame(width: 55, height: 55).cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(cart.item)
                            Text("\(cart.quantity)")
                        }
                    }
                }
            }
        }.frame(width: UIScreen.main.bounds.width - 110, height: UIScreen.main.bounds.height - 350).background(Color.white).cornerRadius(25).onAppear {
            self.cartController.startListener { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
