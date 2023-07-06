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
            StateView(state: Binding.constant(productsVM.state))
            //2 columns in iphone and 4 columns in ipad
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10),
                                     count: UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2), spacing: 10) {
                if let products = productsVM.products {
                    ForEach(products) { product in
                        NavigationLink {
                            productView(product)
                        } label: {
                            productsItem(product)
                        }
                    }
                    .navigationTitle(productsVM.category)
                    .navigationViewStyle(.stack)
                }
            }
        }
        .padding()
        .onAppear() {
            Task {
                await productsVM.fetchProducts()
            }
        }
    }
    
    @ViewBuilder
    private func productsItem(_ product: Product) -> some View {
        VStack{
            AsyncImageView(url: product.thumbnail)
                .cornerRadius(10)
                .frame(width: 150, height: 130)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.title)
                    .foregroundColor(.black)
                    .font(.headline)
                    .lineLimit(1)
                
                productFooter(price: product.price, isFavorite: product.isFavorite)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
        .background(.blue.opacity(0.04))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.5))
        )
    }
    
    @ViewBuilder
    private func productView(_ product: Product) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImageView(url: product.thumbnail)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .cornerRadius(10)
                
                Text(product.description)
                    .font(.headline)
                
                productFooter(price: product.price, isFavorite: product.isFavorite)
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(product.images, id: \.self) { image in
                        AsyncImageView(url: image)
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                            .padding(5)
                    }
                }
                .padding(5)
            }
            .background(Color.gray.opacity(0.25))
        }
        .navigationBarTitle(product.title, displayMode: .inline)
    }
    
    @ViewBuilder
    private func productFooter(price: Int, isFavorite: Bool) -> some View {
        HStack {
            Text("$\(price)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Spacer()
            
            Button(action: {
                //  product.isFavorite.toggle()
            }, label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
            })
        }
    }
    
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(productsVM: ProductsViewModel(category: "smartphones"))
    }
}
