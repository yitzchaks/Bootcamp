//
//  ViewController.swift
//  Challenge
//
//  Created by Yitzchak Schechter on 15/06/2023.
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
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
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
        if isValid(usernameField.text, passwordField.text) {
            loginBtn.isEnabled = true
        } else {
            loginBtn.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Login"
        loginBtn.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondVC = segue.destination as? SecondViewController
        else { return }
        secondVC.name = usernameField.text
        resetFields()
    }
}

