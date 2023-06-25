//
//  SecondViewController.swift
//  Challenge2
//
//  Created by Yitzchak Schechter on 22/06/2023.
//

import UIKit

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: URL
    let images: [URL]
}

var token = ""
var products: [Product] = []

class SecondViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let call = UITableViewCell()
        call.textLabel?.text = products[indexPath.row].title
        return call
    }
    
    public var name: String?
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Welcome"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,  forCellReuseIdentifier: "productCell")
    }

}
