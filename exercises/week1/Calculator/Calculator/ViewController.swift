//
//  ViewController.swift
//  Calculator
//
//  Created by Yitzchak Schechter on 13/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    struct Filds {
        var firstNumber: String?
        var secondNumber: String?
        var operation: String?
        
        func tuples() -> (String?, String?, String?) {
            return (firstNumber, operation, secondNumber)
        }
        func summary() -> String {
            return "\(firstNumber ?? "") \(operation ?? "") \(secondNumber ?? "")"
        }
        func sum() -> String? {
            if let result = NSExpression(format: summary())
                .expressionValue(with: nil, context: nil) as? Double {
                if result.truncatingRemainder(dividingBy: 1) == 0
                    && result <= Double(Int.max) {
                    return String(Int(result))
                } else {
                    return String(result)
                }
            }
            return nil
        }
    }
    
    @IBOutlet weak var input: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var filds = Filds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else {
            return
        }
          
        switch buttonTitle {
        case "0"..."9", ".":
            handleNumber(buttonTitle)
        case "+", "-", "*", "/":
            handleOperation(buttonTitle)
        case "=":
            handleEqual()
        case "<":
            handleRemove()
        case "x":
            handleReset()
        default:
            return
        }
       }
      
    private func handleNumber(_ number: String) {
        if result.text != nil {
            result.text = nil
        }
        if filds.operation == nil {
            if let value = filds.firstNumber {
                filds.firstNumber = value + number
            } else {
                filds.firstNumber = number
            }
        } else {
            if let value = filds.secondNumber {
                filds.secondNumber = value + number
            } else {
                filds.secondNumber = number
            }
        }
        input.text = filds.summary()
    }
      
    private func handleOperation(_ operation: String) {
        if let resultNumber = result.text {
            result.text = nil
            filds.firstNumber = resultNumber
        }
        if filds.secondNumber != nil {
            if let sum = filds.sum() {
                filds = Filds(firstNumber: sum)
            }
        }
        if filds.firstNumber != nil {
            filds.operation = operation
            input.text = filds.summary()
        }
    }
      
    private func handleEqual() {
        if filds.secondNumber != nil {
            if let sum = filds.sum() {
                result.text = String(sum)
            }
            filds = Filds()
        }
    }
    
    private func handleReset() {
        filds = Filds()
        input.text = nil
        result.text = nil
    }
    
    private func handleRemove() {
        if result.text != nil {
            handleReset()
            return
        }
        
        switch filds.tuples() {
        case let (_, _, second?):
            filds.secondNumber = String(second.dropLast())
        case (_, _?, _):
            filds.operation = nil
        case let (first?, _, _):
            filds.firstNumber = String(first.dropLast())
        default:
            return
            
        }
        input.text = filds.summary()
    }
    
}
