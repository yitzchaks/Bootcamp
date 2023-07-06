//
//  ProductsView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryVM: CategoryViewModel
    
    var body: some View {
        ScrollView{
            StateView(state: Binding.constant(categoryVM.state))
            //2 columns in iphone and 4 columns in ipad
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10),
                                     count: UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2), spacing: 10) {
                if let categories = categoryVM.categories {
                    ForEach(categories, id: \.title) { category in
                        NavigationLink {
                            ProductsView(productsVM: ProductsViewModel(category: category.title))
                        } label: {
                            categoriesItem(title: category.title, imege: category.image)
                                .shadow(color: .black.opacity(0.2), radius: 10)
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Categories", displayMode: .inline)
        .onAppear() {
            Task {
                await categoryVM.fetchCategories()
            }
        }
    }
    
    @ViewBuilder
    private func categoriesItem(title: String, imege: String) -> some View {
        ZStack{
            AsyncImageView(url: imege)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
                .padding(.vertical)
            
            Text(title.capitalized)
                .foregroundColor(.white)
                .lineLimit(1)
                .font(.body)
                .bold()
                .frame(maxWidth: 150, maxHeight: 35)
                .roundedCorner(.blue.opacity(0.75), radius: 10, corners: [.bottomLeft, .bottomRight])
                .padding(.top, 115)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(categoryVM: CategoryViewModel())
    }
}
