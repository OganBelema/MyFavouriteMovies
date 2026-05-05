//
//  MyFavouriteMoviesApp.swift
//  MyFavouriteMovies
//
//  Created by Belema on 10/04/2026.
//

import Data
import Domain
import SwiftUI

@main
struct MyFavouriteMoviesApp: App {
    @StateObject private var coordinator = MovieCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(.movieList)
                    .navigationDestination(for: MoviePage.self) { page in
                        coordinator.build(page)
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
