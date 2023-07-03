//
//  ProductCardView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct ProductCardView: View {
    @State private var product: Product
    init(_ product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack{
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ImagePlaceholder()
                }
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
            Text(product.title)
                .foregroundColor(.black)
                .lineLimit(1)
                .font(.title3)
            
            Text("$\(product.price)")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product)
    }
}
