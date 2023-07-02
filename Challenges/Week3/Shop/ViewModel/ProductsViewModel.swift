//
//  ProductsViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 02/07/2023.
//

import Foundation

enum Status {
    case loading, success, error
}

class ProductsViewModel: ObservableObject {
    private let url = "https://balink.onlink.dev/products"
    
    @Published var status: Status = .error
    @Published var token: String?
    @Published var firstname: String?
    @Published var lastname: String?
    @Published var products: [Product] = []
    @Published var categories: [String: [Product]] = [:]
    
    init() {}
    init(_ user: UserResponse) {
        self.token = user.token
        self.firstname = user.firstname ?? ""
        self.lastname = user.lastname ?? ""
    }
    
    @MainActor
    func fetchProducts() {
        Task {
            guard let token = self.token else {
                return
            }
            let headers = [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
            self.status = .loading
            do {
                self.products = try await DataUtils.fetch(url, method: .GET, headers: headers)
                self.createCategories()
                self.status = .success
            } catch {
                self.status = .error
                print(error.localizedDescription)
            }
        }
    }
    
    private func createCategories() {
        self.categories = self.products.reduce(into: [String: [Product]]()) { result, product in
            result[product.category, default: []].append(product)
        }
    }
    
}
