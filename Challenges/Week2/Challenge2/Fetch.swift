//
//  Fetch.swift
//  Challenge2
//
//  Created by Yitzchak Schechter on 25/06/2023.
//

import UIKit

extension URLSession {
    
    func fetch<T: Codable> (
        _ url: String,
        method: String = "GET",
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        self.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    if(T.self == String.self) {
                        let object = String(data: data, encoding: .utf8)
                        completion(.success(object as! T))
                        return
                    }
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}


class FetchesManager {
    
    static let shared = FetchesManager()
    
    let baseURL = "https://balink.onlink.dev"
    let session = URLSession.shared
    var headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
    ]
    
    func registerUser(body: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        let registerUrl = "\(baseURL)/register"
        session.fetch(registerUrl, method: "POST", headers: headers, body: body as [String : Any], completion: completion)
    }
    
    func fetchProducts(token: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let productsUrl = "\(baseURL)/products"
        headers["Authorization"] = "Bearer \(token)"
        session.fetch(productsUrl, method: "GET", headers: headers, completion: completion)
    }
}

