//
//  MovieViewModel.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI
import SwiftUISnackbar

@MainActor
final class MovieViewModel: ObservableObject {
    let movie: Movie
    let isActive: Binding<Bool>
    @Published var showButtons: Bool
    let detailed: Bool
    private let indexingService: SpotlightIndexServiceProtocol
    @Published var loadedPoster: Bool
    @Published var snackbar: Snackbar? = nil
    
    internal init(
        movie: Movie,
        isActive: Binding<Bool>,
        showButtons: Bool = false,
        detailed: Bool,
        indexingService: SpotlightIndexServiceProtocol,
        loadedPoster: Bool = false
    ) {
        self.movie = movie
        self.isActive = isActive
        self.showButtons = showButtons
        self.detailed = detailed
        self.indexingService = indexingService
        self.loadedPoster = loadedPoster
    }
    
    func addToSpotlight() {
        Task {
            do {
                try await self.indexingService.indexSearchableItems([movie])
                showSnackbar(message: "Added index successfully", icon: .success)
            } catch {
                showSnackbar(message: "Failed to remove", icon: .error)
            }
        }
    }
    
    func deleteFromSpotlight() {
        Task {
            do {
                try await self.indexingService.deleteSearchableItems([movie])
                showSnackbar(message: "Removed index successfully", icon: .success)
            } catch {
                showSnackbar(message: "Failed to remove", icon: .error)
            }
        }
    }
    
    private func showSnackbar(message: String, icon: Snackbar.Icon) {
        snackbar = Snackbar(
            message: message,
            properties: Snackbar.Properties(position: .bottom(offset: -40)),
            icon: icon
        )
    }
}
