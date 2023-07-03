//
//  ProductsRequest.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

enum ProductsRequest: requestable {
    case products
    case product(id: Int)
    case productsByIds(ids: [Int])
    
    var url: String {
        let baseUrl = "https://balink.onlink.dev/products"
        switch self {
        case .products:
            return baseUrl
        case .product(let id):
            return "\(baseUrl)/\(id)"
        case .productsByIds:
            return "\(baseUrl)/ids"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .products, .product:
            return .get
        case .productsByIds:
            return .post
        }
    }
    
    var body: Data? {
        switch self {
        case .productsByIds(let ids):
            let body = [ "products": ids ]
            return try? JSONSerialization.data(withJSONObject: body)
        default:
            return nil
        }
    }
}
