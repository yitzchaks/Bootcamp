//
//  ContentView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 28/06/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State private var navigationIsActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(BlueTextFieldStyle())
                    
                    SecuredTextField(
                        title: "Password",
                        password: $password
                    )
                    
                    Button {
                        navigationIsActive = true
                        
                    } label: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }.buttonStyle(BlueButtonStyle())
                        .progressViewStyle(.circular)
                    
                    VStack{
                        NavigationLink("", destination: Text("Home!"), isActive: $navigationIsActive)
                    }.hidden()
                    
                }
            }
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
