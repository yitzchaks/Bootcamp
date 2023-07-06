//
//  HeartRipple.swift
//  Shop
//
//  Created by Yitzchak Schechter on 06/07/2023.
//

import SwiftUI

struct HeartView: View {
    var mode: Bool
    var ripple: Bool
    
    var body: some View {
        if ripple {
            heart()
                .modifier(HeartRipple(color: self.mode ? .red : .gray))
        } else {
            heart()
        }
    }
    
    @ViewBuilder
    private func heart() -> some View {
        Image(systemName: self.mode ? "heart.fill" : "heart")
            .foregroundColor(self.mode ? .red : .gray)
            .animation(.easeIn(duration: 0.25))
    }
}

struct HeartRipple: ViewModifier {
    @State var color: Color
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: isAnimating ? 30 : 15, height: isAnimating ? 30 : 15)
                    .foregroundColor(color)
                    .opacity(isAnimating ? 0.2 : 1)
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: false)) {
                    self.isAnimating = true
                }
            }
            .onDisappear {
                self.isAnimating = false
            }
    }
}
