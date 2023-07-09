//
//  ProductsViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 04/07/2023.
//

import Foundation

class ProductsViewModel: ObservableObject {
    var page: ProductsPage = .defaultPage
    @Published var category: String
    @Published var state: StateModel = .idle
    @Published var products: [Product]?
    @Published var query: String = ""
    
    init(category: String) {
        self.category = category
    }
    
    init(page: ProductsPage) {
        self.page = page
        self.category = page.rawValue
    }
    
    @MainActor
    func fetchProducts() async {
        if self.page != .defaultPage ||  self.products == nil {
            do {
                self.state = .load
                var request: Requestable
                switch self.page {
                case .defaultPage:
                    request = CategoryRequest.category(for: self.category)
                case .favorites:
                    guard let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] else {
                        self.state = .idle
                        return
                    }
                    if favorites.count == 0 {
                        self.state = .idle
                        return
                    }
                    request = ProductsRequest.productsByIds(ids: favorites)
                case .search:
                    if self.query.count == 0 {
                        self.state = .idle
                        return
                    }
                    self.products = nil
                    request = ProductsRequest.search(query: self.query)
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
                        if self.page == .favorites {
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
        if self.page == .favorites {
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
