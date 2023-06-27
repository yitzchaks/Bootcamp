//
//  getPosts.swift
//  Blog
//
//  Created by Yitzchak Schechter on 27/06/2023.
//

import Foundation

class PostsVM: ObservableObject {
    
    let url = "https://jsonplaceholder.typicode.com/posts"
    
    @Published var posts: [Post] = []
    
    @MainActor
    func getPosts() async -> Void {
        do {
            self.posts = try await DataUtils.fetchAndDecode(url)
        } catch {
            print(error)
        }
    }
}
