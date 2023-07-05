//
//  ProductsViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 04/07/2023.
//

import Foundation

class ProductsViewModel: ObservableObject {
    @Published var category: String
    @Published var state: StateModel = .idle
    @Published var products: [Product]?
    
    init(category: String){
        self.category = category
    }
    
    @MainActor
    func fetchProducts() async {
        if self.products != nil {
            return
        }
        do {
            self.state = .load
            let request = CategoryRequest.category(for: self.category)
            self.products = try await RequestManager.fetch(request)
            self.state = .success
        } catch {
            self.state = .error
        }
    }
}
