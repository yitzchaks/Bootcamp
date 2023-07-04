//
//  CartRequest.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

enum CartRequest: Requestable {
    case get
    case add(_ ids: [Int])
    case remove(_ ids: [Int])
    
    var url: String {
        return "https://balink.onlink.dev/cart"
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
    
    var body: Data? {
        switch self {
        case .add(let ids), .remove(let ids):
            let body = [ "products": ids ]
            return try? JSONSerialization.data(withJSONObject: body)
        default:
            return nil
        }
    }
}

