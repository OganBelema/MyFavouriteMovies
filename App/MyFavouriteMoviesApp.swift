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
    var body: some Scene {
        WindowGroup {
            MoviesView(
                viewModel: MovieViewModel(
                    movieInteractor: MovieInteractor(
                        repository: MovieRepository(
                            movieService: MovieService(
                                networkService: NetworkService(
                                    config: APIConfig(
                                        baseURL: ApiConstants.baseURL,
                                        apiKey: ApiConstants.apiKey
                                    )
                                )
                            ),
                            coreDataStack: CoreDataStack.shared,
                            movieDTOMapper: MovieDTOMapper(),
                            movieMapper: MovieMapper(),
                            movieEntityMapper: MovieEntityMapper(),
                            favoriteMovieMapper: FavouriteMovieMapper()
                        )
                    )
                )
            )
        }
    }
}
