//
//  DIContainer.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-18.
//

import SwiftUI

struct DIContainer: @unchecked Sendable {

    let appState: Store<AppState>
    let interactors: Interactors

    init(appState: Store<AppState> = .init(AppState()), interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }

    init(appState: AppState, interactors: Interactors) {
        self.init(appState: Store<AppState>(appState), interactors: interactors)
    }
}

extension DIContainer {
    struct Interactors {
        let moviesInteractor: MoviesListInteractorProtocol
        let indexingInteractor: SpotlightIndexServiceProtocol
        
        static var stub: Self {
            .init(
                moviesInteractor: MoviesListInteractor(),
                indexingInteractor: SpotlightIndexService()
            )
        }

    }
}

extension EnvironmentValues {
    @Entry var injected: DIContainer = DIContainer(interactors: .stub)
}

extension View {
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
