//
//  Styles.swift
//  Shop
//
//  Created by Yitzchak Schechter on 28/06/2023.
//

import SwiftUI
import Foundation

struct BlueTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .frame(width: 300, height: 50)
            .autocapitalization(.none)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            )
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
            .padding()
    }
}

