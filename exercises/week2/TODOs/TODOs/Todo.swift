//
//  Todo.swift
//  TODOs
//
//  Created by Yitzchak Schechter on 19/06/2023.
//

import UIKit

// Custom Color struct implementing Codable for handling RGBA values.
struct Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
    
    // Converting custom Color to UIColor.
    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Init method to create Color from UIColor.
    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

struct Todo: Codable {
    var title: String
    var color: UIColor
    
    // Initializers for creating a Todo.
    init(_ todo: String) {
        self.title = todo
        self.color = Todo.stringToColor(todo)
    }
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
    
    // Keys for encoding/decoding process.
    enum CodingKeys: String, CodingKey {
        case title, color
    }
    
    // Decode a Todo item from a Decoder.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        color = try values.decode(Color.self, forKey: .color).uiColor
    }
    
    // Encode a Todo item to a Encoder.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(Color(uiColor: color), forKey: .color)
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
