//
//  CategoryViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var state: StateModel = .idle
    @Published var categories: [Category]?
    @Published var searchText: String = "!!!"
    
    @MainActor
    func fetchCategories() async {
        if self.categories != nil {
            return
        }
        do {
            self.state = .load
            let request = CategoryRequest.categories
            self.categories = try await RequestManager.fetch(request)
            self.state = .success
        } catch {
            self.state = .error
            print(error.localizedDescription)
        }
    }
}

