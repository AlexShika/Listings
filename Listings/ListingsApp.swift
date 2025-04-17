//
//  ListingsApp.swift
//  Listings
//
//  Created by Alexandru Dinu on 16.04.2025.
//

import SwiftUI

@main
struct ListingsApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.navigationPath) {
                if let specificsViewModel = coordinator.specificsViewModel {
                    SpecificsListView(viewModel: specificsViewModel)
                        .navigationDestination(for: AppCoordinator.Destination.self) { destination in
                            coordinator.view(for: destination)
                        }
                } else {
                    ProgressView("Loading...")
                }
            }
            .environmentObject(coordinator)
        }
    }
}

