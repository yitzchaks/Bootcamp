//
//  Posts.swift
//  Blog
//
//  Created by Yitzchak Schechter on 27/06/2023.
//

import Foundation

struct DataUtils {
    
  static func fetchAndDecode<T: Decodable>(_ url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
}
