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
        if self.products == nil || self.category == "favorites" {
            do {
                self.state = .load
                var request: Requestable
                
                if category == "favorites" {
                    guard let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] else {
                        self.state = .idle
                        return
                    }
                    request = ProductsRequest.productsByIds(ids: favorites)
                } else {
                    request = CategoryRequest.category(for: self.category)
                }
                
                self.products = try await RequestManager.fetch(request)
                self.state = .success
            } catch {
                self.state = .error
            }
        }
        updateFavorites()
    }
    
    @MainActor
    func toggleFavorite(_ id: Int, isFavorite: Bool) async {
        for i in 0..<(self.products?.count ?? 0) {
            if self.products?[i].id == id {
                self.products?[i].isFavorite = !isFavorite
                
                if let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
                    var newFavorites = favorites
                    if !isFavorite {
                        newFavorites.append(id)
                    } else {
                        newFavorites.removeAll(where: { $0 == id })
                        if self.category == "favorites" {
                            self.products?.remove(at: i)
                        }
                    }
                    UserDefaults.standard.set(newFavorites, forKey: "favorites")
                } else {
                    UserDefaults.standard.set([id], forKey: "favorites")
                }
                break
            }
        }
    }
    
    private func updateFavorites() {
        if self.category == "favorites" {
            for i in 0..<(self.products?.count ?? 0) {
                self.products?[i].isFavorite = true
            }
            return
        }
        if let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            for i in 0..<(self.products?.count ?? 0) {
                self.products?[i].isFavorite = favorites.contains(self.products?[i].id ?? 0)
            }
        }
    }
}
