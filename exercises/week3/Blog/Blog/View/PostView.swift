//
//  PostView.swift
//  Blog
//
//  Created by Yitzchak Schechter on 27/06/2023.
//

import SwiftUI

struct PostView: View {
    
    let post: Post
    @StateObject var commentVM = CommentVM()
    
    var body: some View {
        VStack {
            Text(post.body)
                .font(.title2)
                .padding(.bottom, 30)
            Spacer(minLength: 20)
            Text("Comments")
                .font(.title3)
            Divider()
            CommentList()
        }
        .navigationTitle(post.title)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear {
            Task {
                await commentVM.getComments(postId: String(post.id))
            }
        }
    }
    
    private func CommentList() -> some View{
        ScrollView{
            ForEach(commentVM.comments) { comment in
                VStack(alignment: .leading) {
                    Text(comment.name)
                        .font(.body)
                    Text(comment.body)
                        .font(.subheadline)
                    Divider()
                }
            }
        }
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
