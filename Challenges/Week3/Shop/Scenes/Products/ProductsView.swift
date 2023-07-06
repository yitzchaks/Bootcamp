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
                            ScrollView{
                                productView(product, mode: .single)
                            }
                            .navigationBarTitle(product.title.capitalized, displayMode: .inline)
                        } label: {
                            productView(product, mode: .list)
                                .padding(.vertical, 10)
                                .background(.blue.opacity(0.04))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray.opacity(0.5))
                                )
                        }
                    }
                    .navigationTitle(productsVM.category.capitalized)
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
    private func productView(_ product: Product, mode: ProductViewMode) -> some View {
        VStack {
            //image
            switch mode {
            case .list:
                AsyncImageView(url: product.thumbnail)
                    .cornerRadius(10)
                    .frame(width: 150, height: 130)
            case .single:
                sliderView(product.images)
            }
            //body
            VStack(alignment: .leading, spacing: 10) {
                Text(mode == .list ? product.title : product.description)
                    .foregroundColor(.black)
                    .font(.headline)
                    .lineLimit(mode == .list ? 1 : nil)
                
                productFooter(product.id, price: product.price, isFavorite: product.isFavorite)
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func productFooter(_ id: Int, price: Int, isFavorite: Bool) -> some View {
        HStack {
            Text("$\(price)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Spacer()
            
            Button(action: {
                Task {
                    await productsVM.toggleFavorite(id: id)
                }
            }, label: {
                HeartView(mode: isFavorite, ripple: productsVM.isFavoriteToggling == id)
            })
        }
    }
    
    @ViewBuilder
    private func sliderView(_ images: [String]) -> some View {
        TabView {
            ForEach(images.reversed(), id: \.self) { image in
                AsyncImageView(url: image)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height / 2)
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(productsVM: ProductsViewModel(category: "smartphones"))
    }
}
