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

//For View_Previews
let user = UserResponse(
    firstname: "Avi",
    lastname: "Koen",
    token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InVzZXJAZ21haWwuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCIsImlhdCI6MTY4ODAzMTM0NX0.0QV-_69OI_ik16VDc0aeeizoNDbYA9n4yTCs_jwnBFM"
)
