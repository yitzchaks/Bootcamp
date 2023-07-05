//
//  FavoritesRequest.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

enum FavoritesRequest: Requestable {
    case get
    case add(_ id: Int)
    case remove(_ id: Int)
    
    var url: String {
        let baseUrl = "https://balink.onlink.dev/favorites"
        switch self {
        case .get:
            return baseUrl
        case .add(let id):
            return "\(baseUrl)/\(id)"
        case .remove(let id):
            return "\(baseUrl)/\(id)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .get:
            return .get
        case .add:
            return .post
        case .remove:
            return .delete
        }
    }
}
