//
//  ViewController.swift
//  Challenge2
//
//  Created by Yitzchak Schechter on 22/06/2023.
//

import UIKit

func isValid(_ usernameStr:String?, _ passwordStr:String?) -> Bool {
    guard let username = usernameStr,
          let password = passwordStr
    else { return false }
    
    // Regex restricts to alphanumeric and underscore and length should be between 4 to 16.
    let usernameRegex = "^[a-zA-Z_]{4,16}$"
    // Regex restricts to at least one uppercase, one lowercase, one number and one special character and length should be between 8 to 16.
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,16}"
    let usernameTest = NSPredicate(format:"SELF MATCHES %@", usernameRegex)
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    
    return usernameTest.evaluate(with: username) && passwordTest.evaluate(with: password)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func submit(_ sender: UIButton) {
        sender.configuration?.showsActivityIndicator = true
        let secondView = SecondViewController()
        let session = URLSession.shared
        let url = "https://balink.onlink.dev"
        let registerUrl = "\(url)/register"
        let productsUrl = "\(url)/products"
        
        var headers = [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        let body = [
            "firstname": firstnameField.text,
            "lastname": lastnameField.text,
            "username": usernameField.text,
            "password": passwordField.text,
        ]
        print(body)
        
        session.fetch(registerUrl, method: "POST", headers: headers, body: body) {
            (result: Result<String, Error>) in
            switch result {
            case .success(let token):
                print(token)
                headers["Authorization"] = "Bearer \(token)"
                session.fetch(productsUrl, method: "GET", headers: headers) {
                    (result: Result<[Product], Error>) in
                    switch result {
                    case .success(let productsResult):
                        products = productsResult
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(secondView, animated:true)
                            self.loginBtn.configuration?.showsActivityIndicator = false
                            self.resetFields()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print(error)
                            self.loginBtn.configuration?.showsActivityIndicator = false
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.loginBtn.configuration?.showsActivityIndicator = false
                }
            }
        }
    }
    
    private func resetFields () {
        loginBtn.isEnabled = false
        guard let username = usernameField,
              let password = passwordField else { return }
        let fields = [username, password]
        for field in fields {
            field.text = nil
            field.resignFirstResponder()
        }
    }
    
    @IBAction func fields(_ sender: UITextField) {
        //        if isValid(usernameField.text, passwordField.text) {
        //            loginBtn.isEnabled = true
        //        } else {
        //            loginBtn.isEnabled = false
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        //        loginBtn.isEnabled = false
    }
}
