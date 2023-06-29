//
//  LoadButton.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import SwiftUI

struct LoadButton: View {
    var text: String
    @Binding var isLoad: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            isLoad = true
            action()
        } label: {
            if isLoad {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                Text(text)
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
            isLoad: .constant(false),
            action: {print("Action")}
        )
    }
}
