//
//  CellView.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CellView: View {
    var categoryController: CategoriesController
    var category: Categories
    @State private var show = false
    
    var body: some View {
        VStack {
            AnimatedImage(url: URL(string: category.pic)).resizable().frame(height: 270)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(category.name).font(.title).fontWeight(.heavy)
                    Text("$\(category.price)").font(.body).fontWeight(.heavy)
                }
                
                Spacer()
                
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "arrow.right").font(.body).foregroundColor(.black).padding(14)
                }.background(Color.yellow).clipShape(Circle())
            }.padding(.horizontal).padding(.bottom, 6)
        }.background(Color.white).cornerRadius(20).sheet(isPresented: self.$show) {
            OrderView(categoryController: self.categoryController, category: self.category)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(categoryController: CategoriesController(), category: Categories(id: "vsdifbibsgjbi", name: "Test", price: "45.99", pic: "samplePic"))
    }
}
