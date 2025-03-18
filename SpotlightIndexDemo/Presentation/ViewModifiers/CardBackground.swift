//
//  CardBackground.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

// view extension for better modifier access
extension View {
    func cardBackground() -> some View {
        modifier(CardBackground())
    }
}

// view modifier
struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.8), radius: 8)
    }
}
