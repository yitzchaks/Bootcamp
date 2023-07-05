//
//  NetworkManager.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

protocol Requestable {
    var url: String { get }
    var method: RequestMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}

extension Requestable {
    var headers: [String: String] {
        var headers = ["Content-Type": "application/json", "Accept": "*/*"]
        if let token = UserDefaults.standard.string(forKey: "token") {
            headers["Authorization"] = token
        }
        return headers
    }
    var body: Data? { nil }
}

enum RequestMethod: String {
    case get, post, put, delete
    
    var value: String {
        return self.rawValue.uppercased()
    }
}

class RequestManager {
    static func fetch<T: Decodable>(_ request: Requestable) async throws -> T {
        guard let url = URL(string: request.url) else { throw URLError(.badURL) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.value
        urlRequest.httpBody = request.body
        request.headers.forEach {key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        let (data, res) = try await URLSession.shared.data(for: urlRequest)
        if let res = res as? HTTPURLResponse, !(200...299).contains(res.statusCode) {
            print(res.statusCode)
            let error = try JSONDecoder().decode(UserError.self, from: data)
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: error.message])
        }
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
