//
//  RoundedCorner.swift
//  Shop
//
//  Created by Yitzchak Schechter on 04/07/2023.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ color: Color, radius: CGFloat, corners: UIRectCorner) -> some View {
        self.background(color)
            .clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
