//
//  AsyncImageView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 05/07/2023.
//

import SwiftUI

struct AsyncImageView: View {
    @State var url = ""
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            imagePlaceholder()
        }
        .animation(.easeOut)
    }
    
    @ViewBuilder
    private func imagePlaceholder() -> some View {
        ZStack {
            ProgressView()
                .scaleEffect(2)
                .padding()
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray.opacity(0.4))
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
