//
//  ProductsView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var productsVM = ProductsViewModel()
    
    init(){}
    init(_ user: UserResponse) {
        productsVM = ProductsViewModel(user)
        productsVM.fetchProducts()
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                Progress()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(productsVM.categories.sorted(by: { $0.0 < $1.0 }), id: \.key) { key, value in
                        NavigationLink {
                            CategoryView(key, products: value)
                                .navigationTitle(key)
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                    .frame(height: 150)
                                    .padding()
                                
                                Text(key)
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                    .font(.title3)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Categories", displayMode: .inline)
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
    }
    
    
    private func Progress() -> some View{
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
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
