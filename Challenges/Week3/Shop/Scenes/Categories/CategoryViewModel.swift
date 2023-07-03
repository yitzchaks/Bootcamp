//
//  CategoryViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var state: CategoryState = .idle
    @Published var categories: [String] = []
    
    init() {
        Task{
            await self.fetchProducts()
        }
    }
    
//    @MainActor
    func fetchProducts() async {
        self.state = .load
        do {
            let request = CategoryRequest.categories
            self.categories = try await RequestManager.fetch(request)
            self.state = .success
        } catch {
            self.state = .error
            print(error.localizedDescription)
        }
    }
}

