//
//  ProductsViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 04/07/2023.
//

import Foundation

class ProductsViewModel: ObservableObject {
    @Published var state: ProductsState = .idle
    @Published var category = ""
    @Published var products: [Product]?
    
    init(_ category: String){
        Task{
            self.category = category
            await self.fetchProducts()
        }
    }
    
    @MainActor
    private func fetchProducts() async {
        self.state = .load
        do {
            let request = CategoryRequest.category(for: self.category)
            self.products = try await RequestManager.fetch(request)
            self.state = .success
        } catch {
            self.state = .error
            print(error.localizedDescription)
        }
    }
}
