//
//  Login.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var userVM = UserViewModel()
    
    var body: some View {
        ZStack {
            background()
            
            VStack(spacing: 15) {
                Text(userVM.reqType.rawValue)
                    .font(.largeTitle).bold()
                    .padding()
                
                fields()
                
                LoadButton(text: userVM.reqType.rawValue, isLoad: $userVM.load) {
                    Task {
                        await userVM.fetchUser()
                    }
                }
                
                switchScreenButton()
                
                VStack{
                    NavigationLink(isActive: $userVM.success) {
                        if let user = userVM.userData {
                            CategoryView(user)
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
            userVM.reset()
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
            if userVM.reqType == .register {
                TextField("Firstname", text: $userVM.firstname)
                    .textFieldStyle(BlueTextFieldStyle())
                
                TextField("Lastname", text: $userVM.lastname)
                    .textFieldStyle(BlueTextFieldStyle())
            }
            
            TextField("Username", text: $userVM.username)
                .textFieldStyle(BlueTextFieldStyle())
            
            SecuredTextField(
                title: "Password",
                password: $userVM.password
            )
        }
    }
    
    @ViewBuilder
    private func switchScreenButton() -> some View {
        Button {
            switch userVM.reqType {
            case .login:
                userVM.reqType = .register
            case .register:
                userVM.reqType = .login
            }
        } label: {
            switch userVM.reqType {
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
