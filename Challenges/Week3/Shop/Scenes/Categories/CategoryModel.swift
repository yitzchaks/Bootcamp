//
//  CategoryModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 03/07/2023.
//

import Foundation

enum CategoryState {
    case idle, load, success, error
}

struct Category: Decodable {
    let title: String
    let image: String
}

