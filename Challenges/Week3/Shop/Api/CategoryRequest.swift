//
//  CategoriesRequest.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

enum CategoryRequest: Requestable {
    case categories
    case category(for: String)
    
    var url: String {
        let baseUrl = "https://balink.onlink.dev/categories"
        switch self {
        case .categories:
            return "\(baseUrl)?image=true"
        case .category(let forCategory):
            return "\(baseUrl)/\(forCategory)"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
}
