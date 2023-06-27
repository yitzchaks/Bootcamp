//
//  CommentVM.swift
//  Blog
//
//  Created by Yitzchak Schechter on 27/06/2023.
//

import Foundation

class CommentVM: ObservableObject {
    
    let url = "https://jsonplaceholder.typicode.com/comments?postId="
    
    @Published var comments: [Comment] = []
    
    @MainActor
    func getComments(postId: String) async -> Void {
        do {
            self.comments = try await DataUtils.fetchAndDecode(url + postId)
        } catch {
            print(error)
        }
    }
}

