//
//  ProductsView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject private var productsVM = ProductsViewModel()
    
    init(){}
    init(_ user: UserResponse) {
        productsVM = ProductsViewModel(user)
        productsVM.fetchProducts()
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                statusView()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(productsVM.categories.sorted(by: { $0.0 < $1.0 }), id: \.key) { key, value in
                        NavigationLink {
                            ProductsView(key, products: value)
                                .navigationTitle(key)
                        } label: {
                            categoryItem(title: key, imege: value[0].thumbnail)
                        }
                    }
                }
            }
            .navigationBarTitle("Categories", displayMode: .inline)
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder
    private func statusView() -> some View{
        VStack {
            switch self.productsVM.status {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
                    .padding()
            case .success:
                EmptyView()
            case .error:
                Text("Error!")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
        }
    }
    
    @ViewBuilder
    private func categoryItem(title: String, imege: String) -> some View{
        ZStack{
            AsyncImage(url: URL(string: imege)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ImagePlaceholder()
            }
            .frame(width: 150, height: 150)
            .cornerRadius(10)
            .padding()
            
            Text(title)
                .foregroundColor(.white)
                .lineLimit(1)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: 35)
                .background(.blue)
                .position(x: 80, y: 135)
                .cornerRadius(10)
                .padding()
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(user)
    }
}
