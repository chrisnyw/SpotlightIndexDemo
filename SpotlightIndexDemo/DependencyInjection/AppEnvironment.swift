//
//  AppEnvironment.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-18.
//

import UIKit

@MainActor
struct AppEnvironment {
    let diContainer: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {

    static func bootstrap() -> AppEnvironment {
        
        let interactors = configuredInteractors()
        let diContainer = DIContainer(interactors: interactors)
        
        let deepLinksHandler = RealDeepLinksHandler(
            container: diContainer,
            moviesListInteractor: interactors.moviesInteractor
        )
        
        let systemEventsHandler = RealSystemEventsHandler(
            container: diContainer,
            deepLinksHandler: deepLinksHandler
        )
        
        return AppEnvironment(
            diContainer: diContainer,
            systemEventsHandler: systemEventsHandler
        )
    }

    private static func configuredInteractors(
    ) -> DIContainer.Interactors {
        let movies = MoviesListInteractor()
        let indexing = SpotlightIndexService()
        return .init(
            moviesInteractor: movies,
            indexingInteractor: indexing
        )
    }
}
