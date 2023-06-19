//
//  Todo.swift
//  TODOs
//
//  Created by Yitzchak Schechter on 19/06/2023.
//

import UIKit

struct Todo {
    var title: String
    var color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
    
    init(_ todo: String) {
        self.title = todo
        self.color = Todo.stringToColor(todo)
    }
}

extension Todo {
    // Convert a string into a UIColor
    static func stringToColor(_ string: String) -> UIColor {
        var hash = 0
        for i in string.utf16 {
            hash = Int(i) &+ ((hash << 5) &- hash)
        }
        let red = CGFloat((hash >> 16) & 0xFF) / 255.0
        let green = CGFloat((hash >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hash & 0xFF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 0.8)
    }
}
