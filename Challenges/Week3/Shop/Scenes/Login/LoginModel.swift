//
//  User.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import Foundation

enum RequestType: String {
    case register, login
}

struct UserResponse: Codable {
    var firstname: String?
    var lastname: String?
    var token: String
}
