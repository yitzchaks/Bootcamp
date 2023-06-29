//
//  DataUtils.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import Foundation

enum Method: String {
    case GET, POST, PUT, DELETE
}

struct DataUtils {
    static func fetch<T: Decodable>(_ url: String, method: Method = .GET, headers: [String: String]? = nil, body: [String: Any]? = nil) async throws -> T {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, res) = try await URLSession.shared.data(for: request)
        if let res = res as? HTTPURLResponse, !(200...299).contains(res.statusCode) {
            let error = try JSONDecoder().decode(UserError.self, from: data)
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: error.message])
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
