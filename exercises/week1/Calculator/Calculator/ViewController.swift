//
//  ViewController.swift
//  Calculator
//
//  Created by Yitzchak Schechter on 13/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var input: UILabel!
    
    @IBOutlet weak var retulte: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            var text = input.text ?? ""
            text += buttonTitle
            input.text = text
        }
    }
    
}
