//
//  AppState.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-19.
//

import Foundation

struct AppState: Equatable {
    var routing = ViewRouting()
}

extension AppState {
    struct ViewRouting: Equatable {
        var moviesListRouting = MoviesListView.Routing()
    }
}
