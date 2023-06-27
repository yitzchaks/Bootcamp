//
//  ContentView.swift
//  Blog
//
//  Created by Yitzchak Schechter on 27/06/2023.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @StateObject var postsVM = PostsVM()
    
    var body: some View {
        VStack {
            Text("Blog Posts")
                .font(.title)
            List(postsVM.posts) { post in
                Text(post.title)
            }
        }
        .padding()
        .onAppear {
            Task{
                await postsVM.getPosts()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
