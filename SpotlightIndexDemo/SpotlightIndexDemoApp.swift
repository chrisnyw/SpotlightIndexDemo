//
//  SpotlightIndexDemoApp.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import SwiftUI

@main
struct SpotlightIndexDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            appDelegate.rootView
        }
    }
}

extension AppEnvironment {
    var rootView: some View {
        HomeView()
            .onAppear {
                URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
                URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
            }
            .inject(diContainer)
    }
}
