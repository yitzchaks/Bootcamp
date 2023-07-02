//
//  ImagePlaceholder.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import SwiftUI

struct ImagePlaceholder: View {
    var body: some View {
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

struct ImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceholder()
    }
}
