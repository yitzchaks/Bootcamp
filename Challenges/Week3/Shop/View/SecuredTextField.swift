//
//  SecuredTextField.swift
//  Shop
//
//  Created by Yitzchak Schechter on 28/06/2023.
//

import SwiftUI

struct SecuredTextField: View {
    var title: String
    @Binding var password: String
    @State private var showPassword = false
    private var value: Binding<String> {
        .init(
            get: {
                if showPassword {
                    return String(password)
                }
                return String(password).secured()
            },
            set: { newValue in
                if newValue.count > password.count {
                    guard let newCharacter = newValue.last else { return }
                    password.append(newCharacter)
                } else if newValue.count < password.count {
                    password = String(password.dropLast())
                }
            }
        )
    }
    
    var body: some View {
        ZStack(alignment: .trailing)  {
            
            TextField(title, text: value)
                .textFieldStyle(BlueTextFieldStyle())
            
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundColor(.blue)
            }
            .background(.white)
            .offset(x: -10)
            .zIndex(1)
        }
        .padding(.horizontal)
    }
}

extension String {
    func secured() -> String {
        return String(repeating: "•", count: self.count)
    }
}

struct SecuredTextField_Previews: PreviewProvider {
    static var previews: some View {
        SecuredTextField(
            title: "Secured",
            password: .constant("")
        )
    }
}
