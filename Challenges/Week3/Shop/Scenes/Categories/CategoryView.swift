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
        NavigationView {
            ScrollView{
                statusView()
                //2 columns in iphone and 4 columns in ipad
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2), spacing: 10) {
                    if let categories = categoryVM.categories {
                        ForEach(categories, id: \.title) { category in
                            NavigationLink {
                                ProductsView(category.title, products: [product])
                                    .navigationTitle(category.title)
                            } label: {
                                categoryItem(title: category.title, imege: category.image)
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
    
    @ViewBuilder
    private func statusView() -> some View{
        VStack {
            switch self.categoryVM.state {
            case .load:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
                    .padding()
            case .success, .idle:
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
            .padding(.vertical)
            
            Text(title)
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
