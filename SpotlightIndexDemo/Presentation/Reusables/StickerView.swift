//
//  StickerView.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2026-04-14.
//

import SwiftUI

enum StickerStyle {
    /// A soft round highlight that tracks the finger, like a flashlight on glossy paper.
    case spot
    /// A diagonal bright line that sweeps across the sticker with the drag.
    case line
    /// A holographic rainbow sweep that rotates with the drag direction.
    case shimmer
}

struct StickerView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    let style: StickerStyle

    @State private var translation: CGSize = .zero
    @State private var isDragging = false

    init(
        style: StickerStyle = .spot,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.style = style
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let normalizedX = normalized(translation.width, half: size.width / 2)
            let normalizedY = normalized(translation.height, half: size.height / 2)

            ZStack {
                content()
                    .frame(width: size.width, height: size.height)

                highlight(
                    normalizedX: normalizedX,
                    normalizedY: normalizedY,
                    size: size
                )
                .mask {
                    content()
                        .frame(width: size.width, height: size.height)
                }
                .allowsHitTesting(false)
            }
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .rotation3DEffect(
                .degrees(isDragging ? 15 : 0),
                axis: (
                    x: -translation.height,
                    y: translation.width,
                    z: 0
                )
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.interactiveSpring()) {
                            translation = value.translation
                            isDragging = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            translation = .zero
                            isDragging = false
                        }
                    }
            )
        }
    }

    private func normalized(_ value: CGFloat, half: CGFloat) -> CGFloat {
        let safe = max(half, 1)
        return min(max(value / safe, -1), 1)
    }

    @ViewBuilder
    private func highlight(
        normalizedX: CGFloat,
        normalizedY: CGFloat,
        size: CGSize
    ) -> some View {
        switch style {
        case .spot:
            spotHighlight(normalizedX: normalizedX, normalizedY: normalizedY, size: size)
        case .line:
            lineHighlight(normalizedX: normalizedX, normalizedY: normalizedY)
        case .shimmer:
            shimmerHighlight(normalizedX: normalizedX, normalizedY: normalizedY)
        }
    }

    private func spotHighlight(
        normalizedX: CGFloat,
        normalizedY: CGFloat,
        size: CGSize
    ) -> some View {
        let cx = 0.5 + normalizedX * 0.4
        let cy = 0.5 + normalizedY * 0.4
        return RadialGradient(
            colors: [.white.opacity(0.7), .white.opacity(0.0)],
            center: UnitPoint(x: cx, y: cy),
            startRadius: 0,
            endRadius: size.width * 0.4
        )
        .blendMode(.plusLighter)
    }

    private func lineHighlight(
        normalizedX: CGFloat,
        normalizedY: CGFloat
    ) -> some View {
        let shift = (normalizedX + 1) * 0.5
        let tilt = normalizedY * 0.3
        return LinearGradient(
            stops: [
                .init(color: .clear,              location: 0.0),
                .init(color: .white.opacity(0.0), location: max(0, shift - 0.25)),
                .init(color: .white.opacity(0.7), location: shift),
                .init(color: .white.opacity(0.0), location: min(1, shift + 0.25)),
                .init(color: .clear,              location: 1.0)
            ],
            startPoint: UnitPoint(x: 0.0, y: 0.0 + tilt),
            endPoint: UnitPoint(x: 1.0, y: 1.0 - tilt)
        )
        .blendMode(.plusLighter)
    }

    private func shimmerHighlight(
        normalizedX: CGFloat,
        normalizedY: CGFloat
    ) -> some View {
        let angle = Double(normalizedX + normalizedY) * 180
        return AngularGradient(
            colors: [
                .red, .orange, .yellow, .green,
                .blue, .purple, .pink, .red
            ],
            center: .center,
            angle: .degrees(angle)
        )
        .blendMode(.overlay)
        .opacity(0.7)
    }
}

#Preview {
    VStack(spacing: 20) {
        labeledSample("Spot", style: .spot)
        labeledSample("Line", style: .line)
        labeledSample("Shimmer", style: .shimmer)
    }
}

@ViewBuilder
private func labeledSample(_ label: String, style: StickerStyle) -> some View {
    StickerView(style: style) {
        Image(.freeSample)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    .overlay(alignment: .topLeading) {
        Text(label)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.black.opacity(0.5), in: Capsule())
            .padding(16)
    }
}
