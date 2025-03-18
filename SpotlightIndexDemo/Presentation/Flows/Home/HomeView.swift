//
//  HomeView.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        MoviesListView(
            viewModel: MoviesListViewModel(
                interactor: injected.interactors.moviesInteractor,
                indexingService: injected.interactors.indexingInteractor
            )
        )
    }
}

#Preview {
    HomeView()
}
