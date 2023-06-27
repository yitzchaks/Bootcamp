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
        NavigationView {
            List {
                ForEach(postsVM.posts) { post in
                    NavigationLink {
                        PostView(post: post)
                    } label: {
                        Text(post.title)
                    }
                }
            }
            .navigationTitle("Posts")
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
