//
//  ProductView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct ProductView: View {
    @State private var product: Product
    init(_ product: Product) {
        self.product = product
    }
    
    var body: some View {
        ScrollView {
            ProductCardView(product)
                .navigationBarTitle(product.title, displayMode: .inline)
            
            Text(product.description)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(product.images, id: \.self) { image in
                        AsyncImage(url: URL(string: image)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ImagePlaceholder()
                        }
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .padding(5)
                    }
                }
                .padding(5)
            }
            .background(Color.gray.opacity(0.3))
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product)
    }
}
