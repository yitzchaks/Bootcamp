//
//  CategoryView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var productsVM: ProductsViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                if let products = productsVM.products {
                    ForEach(products) { product in
                        NavigationLink {
                            ProductView(product)
                        } label: {
                            ProductCardView(product)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(productsVM.category)
        .navigationViewStyle(.stack)
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(productsVM: ProductsViewModel("smartphones"))
    }
}
