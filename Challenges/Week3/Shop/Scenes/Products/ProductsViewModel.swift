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
    @Published var isFavoriteToggling = 0
    
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
    
    @MainActor
    func toggleFavorite(id: Int) async {
        self.isFavoriteToggling = id
        do {
            var request: FavoritesRequest
            var favoriteStatus: Bool
            if let isFavorite = self.products?.first(where: { $0.id == id })?.isFavorite, isFavorite {
                request = .remove(id)
                favoriteStatus = false
            } else {
                request = .add(id)
                favoriteStatus = true
            }

            let _: SuccessResponse = try await RequestManager.fetch(request)
            for i in 0..<(self.products?.count ?? 0) {
                if self.products?[i].id == id {
                    self.products?[i].isFavorite = favoriteStatus
                    break
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        self.isFavoriteToggling = 0
    }
    
}
