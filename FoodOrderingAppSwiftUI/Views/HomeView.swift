//
//  HomeView.swift
//  FoodOrderingAppSwiftUI
//
//  Created by Nelson Gonzalez on 1/6/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var categoriesController: CategoriesController
    
    var body: some View {
        VStack {
            if self.categoriesController.categories.count != 0 {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(self.categoriesController.categories) { category in
                            CellView(categoryController: self.categoriesController, category: category)
                        }
                    }.padding()
                }.background(Color("Color").edgesIgnoringSafeArea(.all))
            } else {
                Loader()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(categoriesController: CategoriesController())
    }
}
