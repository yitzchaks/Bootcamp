//
//  SecondViewController.swift
//  Challenge
//
//  Created by Yitzchak Schechter on 15/06/2023.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let call = UITableViewCell()
        call.textLabel?.text = products[indexPath.row]
        return call
    }
    
    public var name: String?
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Welcome"
        username.text = name
    }

}
