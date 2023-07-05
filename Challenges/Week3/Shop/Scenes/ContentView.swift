//
//  ContentView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 28/06/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            NavigationLink(tag: StateModel.success, selection: .constant(loginViewModel.state)){
                CategoryView(categoryVM: CategoryViewModel())
            } label: {
                LoginView(loginVM: loginViewModel)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
