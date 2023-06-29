//
//  ContentView.swift
//  Shop
//
//  Created by Yitzchak Schechter on 28/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            Login()
        }
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
