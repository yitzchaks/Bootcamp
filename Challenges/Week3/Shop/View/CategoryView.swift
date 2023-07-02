//
//  CategoryView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct CategoryView: View {
    @State var category: String
    @State var products: [Product]
    @State var categoryTitleHidden: Bool = false
    
    init(_ category: String, products: [Product]) {
        self.category = category
        self.products = products
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(products) { product in
                        NavigationLink {
                            ProductView(product)
                                .onAppear(
                                    perform: { categoryTitleHidden = true }
                                )
                                .onDisappear(
                                    perform: { categoryTitleHidden = false }
                                )
                        } label: {
                            ProductCardView(product)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(categoryTitleHidden)
        .navigationViewStyle(.stack)
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
