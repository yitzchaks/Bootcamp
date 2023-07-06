//
//  LoadButton.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import SwiftUI

struct LoadButton: View {
    var text: String
    var isLoad: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            if isLoad {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                Text(text.capitalized)
            }
        }
        .buttonStyle(BlueButtonStyle())
        .disabled(isLoad)
    }
}

struct LoadButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadButton(
            text: "Button",
            isLoad: false,
            action: {print("Action")}
        )
    }
}
