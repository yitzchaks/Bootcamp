//
//  HeartRipple.swift
//  Shop
//
//  Created by Yitzchak Schechter on 06/07/2023.
//

import SwiftUI

struct HeartRipple: ViewModifier {
    @State var color: Color
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Image(systemName: color == .red ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: isAnimating ? 30 : 15, height: isAnimating ? 30 : 15)
                    .foregroundColor(color)
                    .opacity(isAnimating ? 0.2 : 1)
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: false)) {
                    self.isAnimating = true
                }
            }
            .onDisappear {
                self.isAnimating = false
            }
    }
}
