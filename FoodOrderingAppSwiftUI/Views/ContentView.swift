//
//  ContentView.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var categoriesController = CategoriesController()
    @ObservedObject var cartController = CartController()
    @State private var show = false
    var body: some View {
        ZStack {
        NavigationView {
            HomeView(categoriesController: categoriesController).navigationBarTitle("Home", displayMode: .inline).navigationBarItems(trailing: Button(action: {
                self.show.toggle()
            }, label: {
                Image(systemName: "cart.fill").font(.body).foregroundColor(.black)
            }))
        }
            
            if self.show {
                GeometryReader { _ in
                    CartView(cartController: self.cartController)
                }.background(Color.black.opacity(0.55).edgesIgnoringSafeArea(.all).onAppear {
                    self.cartController.cartItems.removeAll()
                    self.cartController.startListener { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                    }
                }.onTapGesture {
                    self.show.toggle()
                })
            }
        }.animation(.linear(duration: 1.0)).onAppear {
            self.categoriesController.startListener(failure: { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
