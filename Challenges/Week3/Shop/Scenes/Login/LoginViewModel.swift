//
//  UserViewModel.swift
//  Shop
//
//  Created by Yitzchak Schechter on 29/06/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var reqType: RequestType = .login
    @Published var username = ""
    @Published var password = ""
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var state: LoginState = .idle
    @Published var userData: UserResponse?
    
    @MainActor
    func fetchUser() async -> Void {
        self.state = .load
        do {
            var request: LoginRequest
            switch self.reqType {
            case .login:
                request = LoginRequest.login(username: self.username, password: self.password)
            case .register:
                request = LoginRequest.register(username: self.username, password: self.password, firstname: self.firstname, lastname: self.lastname)
            }
            self.userData = try await RequestManager.fetch(request)
            
            if let user = self.userData {
                UserDefaults.standard.setValue(user.token, forKey: "token")
                self.state = .success
            }
        } catch {
            self.state = .error
            print(error.localizedDescription)
        }
    }
    
    func reset() -> Void {
        self.reqType = .login
        self.username = "y@gmail.com"
        self.password = "1234"
        self.firstname = ""
        self.lastname = ""
        self.state = .idle
        self.userData = nil
    }
}
