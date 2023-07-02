//
//  UserViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    private let url = "https://balink.onlink.dev/users/"
    
    @Published var reqType: RequestType = .login
    @Published var username = ""
    @Published var password = ""
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var load = false
    @Published var success = false
    @Published var userData: UserResponse?
    
    @MainActor
    func fetchUser() async -> Void {
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        var body = [
            "username": username,
            "password": password
        ]
        if reqType == .register {
            body["firstname"] = firstname
            body["lastname"] = lastname
        }
        
        do {
            self.userData = try await DataUtils.fetch("\(self.url)\(self.reqType)", method: .POST, headers: headers, body: body)
            if let user = self.userData {
                if user.firstname == nil {
                    self.userData?.firstname = user.firstname
                }
                if user.lastname == nil {
                    self.userData?.lastname = user.lastname
                }
            }
            self.success = true
        } catch {
            self.load = false
            print(error.localizedDescription)
        }
    }
    
    func reset() -> Void {
        self.reqType = .login
        self.username = ""
        self.password = ""
        self.firstname = ""
        self.lastname = ""
        self.load = false
        self.success = false
        self.userData = nil
    }
}
