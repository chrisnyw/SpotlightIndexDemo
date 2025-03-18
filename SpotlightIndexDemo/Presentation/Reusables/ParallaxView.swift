//
//  ParallaxView.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

struct ParallaxView<Background: View, Foreground: View>: View {
    @ViewBuilder let background: () -> Background
    @ViewBuilder let foreground: (() -> Foreground)?

    @State private var translation: CGSize = .zero
    @State private var isDragging = false
    
    init(@ViewBuilder background: @escaping () -> Background, @ViewBuilder foreground: @escaping (() -> Foreground)) {
        self.background = background
        self.foreground = foreground
    }
    
    init(@ViewBuilder background: @escaping () -> Background) where Foreground == EmptyView {
        self.background = background
        self.foreground = nil
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                background()
                    // Set the background view to a bit larger
                    // to advoid showing the edge of the assets
                    .frame(
                        width: geometry.size.width * 1.2,
                        height: geometry.size.height * 1.2
                    )
                    // Set the moving offer of the background view
                    .offset(
                        x: translation.width / 10,
                        y: translation.height / 10
                    )
                foreground?()
                    // Set the moving offer of the foreground view
                    .offset(
                        x: translation.width / 5,
                        y: translation.height / 5
                    )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .rotation3DEffect(
                .degrees(isDragging ? 10: 0),
                axis: (
                    x: -translation.height,
                    y: translation.width,
                    z: 0.0
                )
            )
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            translation = value.translation
                            isDragging = true
                        }
                    })
                    .onEnded({ value in
                        withAnimation {
                            translation = .zero
                            isDragging = false
                        }
                    })
            )
        }
    }
}

#Preview {
    ParallaxView(
        background: {
            Image("grass")
                .resizable()
                .aspectRatio(contentMode: .fill)
        },
        foreground: {
            Image("balloon")
                .resizable()
                .aspectRatio(contentMode: .fit)
        })
    .frame(width: 300, height: 500)
    
//    ParallaxView(
//        background: {
//            Image("natrual")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//        },
//        foreground: {
//            Text("Parallax")
//                .foregroundStyle(Color.white)
//                .font(.system(size: 50, weight: .bold))
//        }
//    )
//    .frame(width: 300, height: 500)
//
//    ParallaxView(
//        background: {
//            Image("natrual")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//        }
//    )
//    .frame(width: 300, height: 500)
}
