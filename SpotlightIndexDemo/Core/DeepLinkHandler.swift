//
//  DeepLinkHandler.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-19.
//

import Foundation

enum DeepLink: Equatable {
    case showMovie(id: String)
}

// MARK: - DeepLinksHandler

@MainActor
protocol DeepLinksHandler {
    func open(deepLink: DeepLink)
}

struct RealDeepLinksHandler: DeepLinksHandler {
    
    private let container: DIContainer
    private let moviesListInteractor: MoviesListInteractorProtocol
    
    init(
        container: DIContainer,
        moviesListInteractor: MoviesListInteractorProtocol
    ) {
        self.container = container
        self.moviesListInteractor = moviesListInteractor
    }
    
    func open(deepLink: DeepLink) {
        Task {
            switch deepLink {
            case let .showMovie(movieId):
                guard let movie = await self.moviesListInteractor.getMovie(from: movieId) else { return }
                
                let routeToDestination = { @Sendable in
                    self.container.appState.bulkUpdate {
                        $0.routing.moviesListRouting.movie = movie
                    }
                }
                /*
                 SwiftUI is unable to perform complex navigation involving
                 simultaneous dismissal or older screens and presenting new ones.
                 A work around is to perform the navigation in two steps:
                 */
                let defaultRouting = AppState.ViewRouting()
                if container.appState.value.routing != defaultRouting {
                    self.container.appState[\.routing] = defaultRouting
                    let delay: DispatchTime = .now() + 1.5
                    DispatchQueue.main.asyncAfter(deadline: delay, execute: routeToDestination)
                } else {
                    routeToDestination()
                }
            }
        }
    }
}
