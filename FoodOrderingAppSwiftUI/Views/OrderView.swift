//
//  OrderView.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderView: View {
    var categoryController: CategoriesController
    var category: Categories
    @State private var cash = false
    @State private var quick = false
    @State private var quantity = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            AnimatedImage(url: URL(string: category.pic)).resizable().frame(height: UIScreen.main.bounds.height / 2 - 100)
            
            VStack(alignment: .leading, spacing: 25) {
                Text(category.name).fontWeight(.heavy).font(.title)
                Text("$\(category.price)").fontWeight(.heavy).font(.title)
                
                Toggle(isOn: $cash) {
                    Text("Cash on Delivery")
                }
                
                Toggle(isOn: $quick) {
                    Text("Quick Delivery")
                }
                
                Stepper(onIncrement: {
                    self.quantity += 1
                }, onDecrement: {
                    if self.quantity != 0 {
                        self.quantity -= 1
                    } else if self.quantity == 0 {
                        self.quantity = 0
                    }
                }) {
                    Text("Quantity \(self.quantity)")
                }
                if self.quantity != 0 {
                Button(action: {
                    
                    self.categoryController.addItem(item: self.category.name, quantity: self.quantity, quickDelivery: self.quick, cashOnDelivery: self.cash, pic: self.category.pic) { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                   
                }) {
                    Text("Add To Cart").padding(.vertical).frame(width: UIScreen.main.bounds.width - 30)
                    }.background(Color.orange).foregroundColor(.white).cornerRadius(20)
                
            }
            }.padding()
            Spacer()
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(categoryController: CategoriesController(), category: Categories(id: "vsdifbibsgjbi", name: "Test", price: "45.99", pic: "samplePic"))
    }
}
