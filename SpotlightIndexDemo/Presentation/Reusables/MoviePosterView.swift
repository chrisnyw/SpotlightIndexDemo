//
//  MoviePosterView.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

struct MoviePosterView: View {
    private let imageUrlStr: String
    private let contentMode: ContentMode?
    private let loadedPoster: Binding<Bool>?
    init(imageUrlStr: String, contentMode: ContentMode? = nil, loadedPoster: Binding<Bool>? = nil) {
        self.imageUrlStr = imageUrlStr
        self.contentMode = contentMode
        self.loadedPoster = loadedPoster
    }
    var body: some View {
        AsyncImage(url: URL(string: imageUrlStr)) { image in
            if let contentMode {
                image.resizable()
                    .aspectRatio(contentMode: contentMode)
                    .onAppear {
                        loadedPoster?.wrappedValue = true
                    }
            } else {
                image.resizable()
                    .onAppear {
                        loadedPoster?.wrappedValue = true
                    }
            }
                
        } placeholder: {
            EmptyView()
        }
    }
}
