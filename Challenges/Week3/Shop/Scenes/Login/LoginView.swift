//
//  Login.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View {
        ZStack {
            background()
            
            VStack(spacing: 15) {
                Text(loginVM.reqType.rawValue)
                    .font(.largeTitle).bold()
                    .padding()
                
                fields()
                
                LoadButton(text: loginVM.reqType.rawValue, isLoad: loginVM.state == .load) {
                    Task {
                        await loginVM.fetchUser()
                    }
                }
                
                switchScreenButton()
                
                VStack{
                    NavigationLink(isActive: .constant(loginVM.state == .success)) {
                        if let user = loginVM.userData {
                            CategoryView(categoryVM: CategoryViewModel())
                        } else {
                            Text("Error")
                        }
                    } label: {
                        EmptyView()
                    }
                }.hidden()
            }
        }
        .onAppear {
            loginVM.reset()
        }
    }
    
    @ViewBuilder
    private func background() -> some View {
        ZStack {
            Color.blue
                .ignoresSafeArea(.all)
            Circle().scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle().scale(1.35)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    private func fields() -> some View {
        VStack(spacing: 15) {
            if loginVM.reqType == .register {
                TextField("Firstname", text: $loginVM.firstname)
                    .textFieldStyle(BlueTextFieldStyle())
                
                TextField("Lastname", text: $loginVM.lastname)
                    .textFieldStyle(BlueTextFieldStyle())
            }
            
            TextField("Username", text: $loginVM.username)
                .textFieldStyle(BlueTextFieldStyle())
            
            SecuredTextField(
                title: "Password",
                password: $loginVM.password
            )
        }
    }
    
    @ViewBuilder
    private func switchScreenButton() -> some View {
        Button {
            switch loginVM.reqType {
            case .login:
                loginVM.reqType = .register
            case .register:
                loginVM.reqType = .login
            }
        } label: {
            switch loginVM.reqType {
            case .login:
                Text("Register")
            case .register:
                Text("Login")
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
