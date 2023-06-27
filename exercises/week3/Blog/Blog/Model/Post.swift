//
//  Post.swift
//  Blog
//
//  Created by Yitzchak Schechter on 27/06/2023.
//

import Foundation

struct Post: Decodable, Identifiable {
     let userId: Int
     let id: Int
     let title: String
     let body: String
}
