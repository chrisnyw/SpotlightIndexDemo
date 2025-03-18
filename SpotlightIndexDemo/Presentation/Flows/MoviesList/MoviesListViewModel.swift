//
//  MoviesListViewModel.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

@MainActor
final class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var selectedMovie: Movie?
    @Published var enlargedMovie: Movie?
    private let interactor: MoviesListInteractorProtocol
    let indexingService: SpotlightIndexServiceProtocol
    
    init(interactor: MoviesListInteractorProtocol, indexingService: SpotlightIndexServiceProtocol) {
        self.interactor = interactor
        self.indexingService = indexingService
    }
    
    func loadMoviesList() async {
        self.movies = await self.interactor.getMoviesList()
    }
    
    func deepLinkToMovie(movie: Movie?) {
        self.selected(movie: movie)
    }
    
    func didTapOnMovie(movie: Movie) {
        self.selected(movie: movie)
    }
    
    func didDoubleTapMovie(movie: Movie) {
        withAnimation(.spring) { [weak self] in
            self?.enlargedMovie = movie
        }
    }
    
    private func selected(movie: Movie?) {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) { [weak self] in
            self?.selectedMovie = movie
        }
    }
}
