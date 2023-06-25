//
//  ViewController.swift
//  Challenge2
//
//  Created by Yitzchak Schechter on 22/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    private var fields: Fields!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        self.fields = Fields(
            firstname: firstnameField,
            lastname: lastnameField,
            username: usernameField,
            password: passwordField
        )
    }
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func submit(_ sender: UIButton) {
        if self.fields.validateFields() {
            
            sender.configuration?.showsActivityIndicator = true
            let body = fields.getFields()
            
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
            self?.fields.reset()
        }
    }
    
}
