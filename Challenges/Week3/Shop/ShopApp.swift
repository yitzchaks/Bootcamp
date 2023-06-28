//
//  ShopApp.swift
//  Shop
//
//  Created by Yitzchak Schechter on 28/06/2023.
//

import SwiftUI

@main
struct ShopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
