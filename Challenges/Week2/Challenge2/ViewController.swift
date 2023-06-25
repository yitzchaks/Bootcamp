//
//  ViewController.swift
//  Challenge2
//
//  Created by Yitzchak Schechter on 22/06/2023.
//

import UIKit

enum Fields: String {
    case firstname
    case lastname
    case username
    case password
}

func isValid(_ input: String?, type: Fields?) -> Bool {
    guard let input = input,
          let type = type else { return false }
    
    var regex: String
    switch type {
    case .firstname:
        regex = "^[a-zA-Z_]{1,30}$"
    case .lastname:
        regex = "^[a-zA-Z_]{1,30}$"
    case .username:
        // Regex for email format validation.
        regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    case .password:
        regex = "^.{1,30}$"
    }
    let test = NSPredicate(format: "SELF MATCHES %@", regex)
    return test.evaluate(with: input)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    private var fields: [UITextField] = []
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func submit(_ sender: UIButton) {
        sender.configuration?.showsActivityIndicator = true
        
        var body: [String: Any] = [:]
        for field in self.fields {
            guard let placeholder = field.placeholder?.lowercased() else { return }
            body[placeholder] = field.text
        }
        
        FetchesManager.shared.registerUser(body: body as [String : Any]) {
            [weak self] (result: Result<String, Error>) in
            switch result {
            case .success(let tokenResult):
                token = tokenResult
                FetchesManager.shared.fetchProducts(token: token) {
                    (result: Result<[Product], Error>) in
                    switch result {
                    case .success(let productsResult):
                        products = productsResult
                        self?.handleSuccess()
                    case .failure(let error):
                        self?.handleError(error)
                    }
                }
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    private func resetFields () {
        for field in self.fields  {
            field.text = nil
            field.resignFirstResponder()
        }
    }
    
    private func handleError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            print(error)
            self?.loginBtn.configuration?.showsActivityIndicator = false
        }
    }
    
    private func handleSuccess() {
        DispatchQueue.main.async { [weak self] in
            let secondView = SecondViewController()
            self?.navigationController?.pushViewController(secondView, animated:true)
            self?.loginBtn.configuration?.showsActivityIndicator = false
            self?.resetFields()
        }
    }
    
    @IBAction func fields(_ sender: UITextField) {
        guard let placeholder = sender.placeholder else { return }
        let field = Fields(rawValue: placeholder.lowercased())
        if isValid(sender.text, type: field) {
            sender.layer.borderWidth = 0.0
        } else {
            sender.layer.borderWidth = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        self.fields = [
            self.firstnameField,
            self.lastnameField,
            self.usernameField,
            self.passwordField,
        ]
        for field in self.fields {
            field.layer.borderColor = UIColor.systemRed.cgColor
            field.layer.cornerRadius = 6.0
        }
    }
}
