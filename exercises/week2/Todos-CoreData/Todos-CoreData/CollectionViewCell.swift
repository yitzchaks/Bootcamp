//
//  CollectionViewCell.swift
//  Todos-CoreData
//
//  Created by Yitzchak Schechter on 21/06/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    // Called after the cell has been loaded
    override func awakeFromNib(){
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    func setup(_ todo: Todo) {
        self.backgroundColor = todo.color?.toColor
        titleLabel.text = todo.title ?? ""
    }
}
