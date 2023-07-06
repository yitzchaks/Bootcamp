//
//  LoginRequest.swift
//  Shop
//
//  Created by Yitzchak Schechter on 06/07/2023.
//

import Foundation

enum LoginRequest: Requestable {
    case register(username: String, password: String, firstname: String, lastname: String)
    case login(username: String, password: String)
    case reset(newpassword: String)
    case delete
    
    var url: String {
        let baseUrl = "https://balink.onlink.dev/users"
        switch self {
        case .register:
            return "\(baseUrl)/register"
        case .login:
            return "\(baseUrl)/login"
        case .reset:
            return "\(baseUrl)/reset-password"
        case .delete:
            return "\(baseUrl)/delete"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .register, .login:
            return .post
        case .reset:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var body: Data? {
        var body: [String: String]
        switch self {
        case .register(let username, let password, let firstname, let lastname):
            body = [
                "username": username,
                "password": password,
                "firstname": firstname,
                "lastname": lastname
            ]
        case .login(let username, let password):
            body = [
                "username": username,
                "password": password
            ]
        case .reset(let newpassword):
            body = [
                "newpassword": newpassword
            ]
        default:
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: body)
    }
}
