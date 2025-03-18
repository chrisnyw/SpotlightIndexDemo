//
//  ScaleAndDimButtonStyle.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

struct ScaleAndDimButtonStyle: ButtonStyle {
    let scale: Double
    let opacity: Double
    
    init(scale: Double = 0.95, opacity: Double = 0.75) {
        self.scale = scale
        self.opacity = opacity
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? self.scale : 1.0)
            .opacity(configuration.isPressed ? self.opacity : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
