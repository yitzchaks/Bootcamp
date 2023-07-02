//
//  ProductCardView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct ProductCardView: View {
    @State var product: Product
    init(_ product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ImagePlaceholder()
            }
            .frame(width: 150, height: 150)
            .cornerRadius(10)
            .padding(.bottom, 10)
            Text(product.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(1)
            Text("$\(product.price)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

//struct ProductCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCardView()
//    }
//}
