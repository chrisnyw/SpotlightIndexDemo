//
//  SystemEventsHandler.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-19.
//

import UIKit
import Combine

@MainActor
protocol SystemEventsHandler {
    func sceneOpenSpotlightIndex(movieId: String)
}

struct RealSystemEventsHandler: SystemEventsHandler {

    let container: DIContainer
    let deepLinksHandler: DeepLinksHandler

    init(
        container: DIContainer,
        deepLinksHandler: DeepLinksHandler
    ) {
        self.container = container
        self.deepLinksHandler = deepLinksHandler
    }

    func sceneOpenSpotlightIndex(movieId: String) {
        debugPrint("handling deep link movieId: \(movieId)")
        self.deepLinksHandler.open(deepLink: .showMovie(id: movieId))
    }
}
