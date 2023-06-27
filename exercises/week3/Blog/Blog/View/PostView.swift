//
//  PostView.swift
//  Blog
//
//  Created by Yitzchak Schechter on 27/06/2023.
//

import SwiftUI

struct PostView: View {
    
    let post: Post
    
    var body: some View {
        ScrollView {
            Text(post.title)
                .font(.title)
            Divider()
            Text(post.body)
        }
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
