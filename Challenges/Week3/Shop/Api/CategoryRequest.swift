//
//  CategoriesRequest.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

enum CategoryRequest: requestable {
    case categories
    case category(for: String)
    
    var url: String {
        return "https://balink.onlink.dev/categories?image=true"
    }
    
    var method: RequestMethod {
        return .get
    }
}
