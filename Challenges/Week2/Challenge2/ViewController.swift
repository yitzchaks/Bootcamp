//
//  ViewController.swift
//  Challenge2
//
//  Created by Yitzchak Schechter on 22/06/2023.
//

import UIKit

func isValid(_ input: String?, type: String?) -> Bool {
    guard let input = input,
          let type = type else { return false }
    
    var regex: String
    switch type {
    case "firstname":
        regex = "^[a-zA-Z_]{1,30}$"
    case "lastname":
        regex = "^[a-zA-Z_]{1,30}$"
    case "username":
        // Regex for email format validation.
        regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    case "password":
        regex = "^.{1,30}$"
    default:
        return false
    }
    let test = NSPredicate(format: "SELF MATCHES %@", regex)
    return test.evaluate(with: input)
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
        
        session.fetch(registerUrl, method: "POST", headers: headers, body: body as [String : Any]) {
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
        let textField = sender.placeholder?.lowercased()
        if isValid(sender.text, type: textField) {
            sender.layer.borderWidth = 0.0
        } else {
            sender.layer.borderWidth = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        let fields = [
            firstnameField,
            lastnameField,
            usernameField,
            passwordField,
        ]
        for field in fields {
            field?.layer.borderColor = UIColor.systemRed.cgColor
            field?.layer.cornerRadius = 6.0
        }
    }
}
