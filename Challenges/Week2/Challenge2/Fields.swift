//
//  Fields.swift
//  Challenge2
//
//  Created by Yitzchak Schechter on 25/06/2023.
//

import UIKit

class Fields {
    let firstname: UITextField
    let lastname: UITextField
    let username: UITextField
    let password: UITextField
    let fields: [UITextField]
    
    init(
        firstname: UITextField,
        lastname: UITextField,
        username: UITextField,
        password: UITextField
    ){
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.password = password
        self.fields = [self.firstname, self.lastname, self.username, self.password]
        for field in self.fields {
            field.layer.borderColor = UIColor.systemRed.cgColor
            field.layer.cornerRadius = 6.0
        }
    }
    
    private func isValid(_ field: UITextField) -> Bool {
        guard let text = field.text,
              let placeholder = field.placeholder?.lowercased() else { return false }
        
        var regex: String
        enum FieldsKeys: String {
            case firstname,lastname,username,password
        }
        switch FieldsKeys(rawValue: placeholder) {
        case .firstname, .lastname:
            regex = "^[a-zA-Z_]{1,30}$"
        case .username:
            // Regex for email format validation.
            regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        case .password:
            regex = "^.{1,30}$"
        case .none:
            return false
        }
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: text)
    }
    
    private func validateField(_ field: UITextField) -> Bool {
        if isValid(field) {
            field.layer.borderWidth = 0.0
            return true
        } else {
            field.layer.borderWidth = 1.0
            return false
        }
    }
    
    func validateFields() -> Bool {
        return fields.reduce(true) { (result, field) -> Bool in
            return result && validateField(field)
        }
    }
    
    func getFields() -> [String: String] {
        var fields: [String: String] = [:]
        for field in self.fields {
            fields[field.placeholder?.lowercased() ?? ""] = field.text
        }
        return fields
    }
    
    func reset() {
        for field in self.fields {
            field.text = ""
            field.resignFirstResponder()
        }
    }
    
}
