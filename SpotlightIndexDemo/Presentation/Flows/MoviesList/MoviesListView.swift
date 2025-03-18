//
//  MoviesListView.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI
import Combine

struct MoviesListView: View {
    @Environment(\.injected) private var injected: DIContainer
    @State private var routingState: Routing = .init()
    
    @StateObject var viewModel: MoviesListViewModel
    @State var scale: CGFloat = 1.0
    @Namespace var namespace
    
    @State var isShowingLarge: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        Button(action: {
                            viewModel.didTapOnMovie(movie: movie)
                        }, label: {
                            movieCardView(movie: movie)
                                .matchedGeometryEffect(id: movie.id, in: namespace, isSource: viewModel.selectedMovie?.id != movie.id)
                        })
                        .buttonStyle(.doubleTapHandler {
                            viewModel.didDoubleTapMovie(movie: movie)
                        })
//                        .buttonStyle(ScaleAndDimButtonStyle())
                        .listRowSeparator(.hidden)
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(PlainListStyle())
                .navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.large)
                
                // Shows popover movie poster with parallax effect
                if let movie = viewModel.enlargedMovie {
                    popoverMoviePoster(movie: movie)
                }
            }
        }
        .onReceive(routingUpdate) { self.routingState = $0 }
        .onChange(of: routingState.movie, initial: true, { _, movie in
            viewModel.deepLinkToMovie(movie: movie)
        })
        .modal(bindable: $viewModel.selectedMovie, destination: { movie in
            movieCardView(movie: movie)
                .matchedGeometryEffect(id: movie.id, in: namespace, isSource: viewModel.selectedMovie?.id == movie.id)
        })
        .task {
            await viewModel.loadMoviesList()
        }
    }
    
    private func movieCardView(movie: Movie) -> some View {
        MovieView(
            viewModel: MovieViewModel(
                movie: movie,
                isActive: $viewModel.selectedMovie.toBoolBinding,
                detailed: viewModel.selectedMovie?.id == movie.id,
                indexingService: viewModel.indexingService
            )
        )
        .cardBackground()
    }
    
    private func popoverMoviePoster(movie: Movie) -> some View {
        ParallaxView(
            background: {
                MoviePosterView(imageUrlStr: movie.image, contentMode: .fill)
            }
        )
        .opacity(isShowingLarge ? 1 : 0)
        .scaleEffect(isShowingLarge ? 1 : 0.3)
        .padding()
        .onAppear {
            withAnimation(.easeInOut) {
                isShowingLarge = true
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                isShowingLarge = false
            } completion: {
                viewModel.enlargedMovie = nil // without animation
            }
        }
    }
}

// MARK: - Routing

extension MoviesListView {
    struct Routing: Equatable {
        var movie: Movie?
    }
}

// MARK: - State Updates

private extension MoviesListView {
    private var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.moviesListRouting)
    }
}

#Preview {
    MoviesListView(
        viewModel: MoviesListViewModel(
            interactor: MoviesListInteractor(),
            indexingService: SpotlightIndexService()
        )
    )
}
