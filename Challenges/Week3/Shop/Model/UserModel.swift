//
//  User.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import Foundation

enum RequestType: String {
    case register = "Register"
    case login = "Login"
}

struct UserResponse: Codable {
    var firstname: String?
    var lastname: String?
    var token: String
}

struct UserError: Codable {
    let code: String
    let message: String
    let status: Int
}
