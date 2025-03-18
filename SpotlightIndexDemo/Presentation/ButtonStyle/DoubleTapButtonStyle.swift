//
//  DoubleTapButtonStyle.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

struct DoubleTapButtonStyle: PrimitiveButtonStyle {
    typealias TapHandler = () -> Void
    
    private let scale: Double
    private let opacity: Double
    private let doubleTapHandler: TapHandler
    @GestureState private var isPressed = false
    
    init(scale: Double, opacity: Double, doubleTapHandler: @escaping TapHandler) {
        self.scale = scale
        self.opacity = opacity
        self.doubleTapHandler = doubleTapHandler
    }
    
    /// A drag gesture that is solely used to keep tracked of the pressed state of the button.
    private var pressedStateGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating(self.$isPressed) { _, isPressed, _ in
                guard !isPressed else { return }
                isPressed = true
            }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(self.isPressed ? self.scale : 1.0)
            .opacity(self.isPressed ? self.opacity : 1)
            .animation(.easeInOut, value: self.isPressed)
            
            /// Adding the simultaneous gesture with single tap to ensure it doesn't break .
            .simultaneousGesture(self.pressedStateGesture)
        
            /// Adding both single and double tap gestures.
            .onTapGesture(count: 1, perform: configuration.trigger)
            .onTapGesture(count: 2, perform: self.doubleTapHandler)
    }
}

/// Using Static Member Lookup in combination with a method to configure the double tap.
extension PrimitiveButtonStyle where Self == DoubleTapButtonStyle {
    static func doubleTapHandler(
        scale: Double = 0.95,
        opacity: Double = 0.75,
        action: @escaping DoubleTapButtonStyle.TapHandler
    ) -> DoubleTapButtonStyle {
        DoubleTapButtonStyle(
            scale: scale,
            opacity: opacity,
            doubleTapHandler: action
        )
    }
}
