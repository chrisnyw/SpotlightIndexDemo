//
//  MovieView.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel: MovieViewModel
    
    struct ViewConstants {
        static let maxCardHeight: CGFloat = 500
        static let detailedOffset: CGFloat = 500
        static let bottomInfoYOffset: CGFloat = 0
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                MoviePosterView(imageUrlStr: viewModel.movie.image, contentMode: .fill, loadedPoster: $viewModel.loadedPoster)
                    .overlay(closeButton , alignment: .topTrailing)
                    .overlay(indexingButton, alignment: .topLeading)
                    .frame(maxWidth: .infinity, idealHeight: viewModel.detailed ? nil : ViewConstants.maxCardHeight)
                VStack(alignment: .leading, spacing: .zero) {
                    titleView
                    infosTile
                }
                .offset(y: viewModel.detailed ? ViewConstants.detailedOffset : ViewConstants.bottomInfoYOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: viewModel.detailed ? .infinity : ViewConstants.maxCardHeight)
        }
        .snackbarView(snackbar: $viewModel.snackbar)
        .onAppear {
            if viewModel.detailed {
                withAnimation(.easeInOut.delay(0.5)) {
                    viewModel.showButtons.toggle()
                }
            }
        }
    }
    
    private func dismiss() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
            self.viewModel.isActive.wrappedValue = false
        }
    }
    
    @ViewBuilder
    private var closeButton: some View {
        if viewModel.showButtons {
            Button(action: {
                dismiss()
            }, label: {
                resizableSFSymbol(name: "xmark.circle.fill")
                    .padding([.top, .trailing], 25)
            })
        }
    }
    
    @ViewBuilder
    private var indexingButton: some View {
        if viewModel.showButtons {
            HStack {
                Button(action: {
                    viewModel.addToSpotlight()
                }, label: {
                    resizableSFSymbol(name: "text.badge.plus")
                })
                Button(action: {
                    viewModel.deleteFromSpotlight()
                }, label: {
                    resizableSFSymbol(name: "text.badge.minus")
                })
            }
            .padding([.top, .leading], 25)
        }
    }
    
    private func resizableSFSymbol(name: String) -> some View {
        Image(systemName: name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.white)
            .frame(width: 25, height: 25)
    }
    
    private var titleView: some View {
        Text(viewModel.movie.title)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding()
    }
    
    private var infosTile: some View {
        VStack {
            HStack(spacing: 14) {
                Text("\(viewModel.movie.rating) \(Image(systemName: "star.fill"))")
                    .bold()
                    .foregroundStyle(.white)
                Text(viewModel.movie.category)
                    .font(.caption)
                    .foregroundStyle(.white)
                Spacer()
                Text(viewModel.movie.duration)
                    .font(.caption)
                    .foregroundStyle(.white)
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            if viewModel.detailed {
                VStack {
                    Text(viewModel.movie.description)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding()
            }
        }.background(Rectangle().foregroundStyle(.ultraThinMaterial))
    }
}
