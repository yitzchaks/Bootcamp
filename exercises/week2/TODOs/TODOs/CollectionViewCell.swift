//
//  CollectionViewCell.swift
//  TODOs
//
//  Created by Yitzchak Schechter on 18/06/2023.
//

import UIKit

// Custom CollectionViewCell class
class CollectionViewCell: UICollectionViewCell {
    // Outlet for the label to display the title
    @IBOutlet weak var titleLabel: UILabel!
    
    // Called after the cell has been loaded
    override func awakeFromNib(){
        super.awakeFromNib()
        // Set the corner radius of the cell for rounded corners
        layer.cornerRadius = 10
    }
    
    // Setup function to configure the cell with a background color and title
    func setup(_ todo: Todo) {
        self.backgroundColor = todo.color
        titleLabel.text = "\(todo.title)"
    }
}
