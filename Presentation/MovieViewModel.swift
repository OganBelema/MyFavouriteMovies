//
//  MovieViewModel.swift
//  MyFavouriteMovies
//
//  Created by Belema on 30/04/2026.
//

import Domain
import Combine
import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    @Published var uiState: MovieUIState = .nothing
    private let movieInteractor: MovieInteractorProtocol

    init(movieInteractor: MovieInteractor) {
        self.movieInteractor = movieInteractor
    }

    @MainActor
    func loadMovies() async {
        do {
            uiState = .loading
            let movies = try await movieInteractor.getMovies()
            let favouriteMovies = try await movieInteractor.getFavourites()
            let movieUIData = movies.map { item in
                MovieUIData(
                    id: item.id,
                    title: item.title,
                    releaseDate: item.releaseDate,
                    overview: item.overview,
                    posterPath: item.posterPath,
                    popularity: item.popularity,
                    voteAverage: item.voteAverage,
                    isFavorite: favouriteMovies.contains(where: { favMovie in
                        item.id == favMovie.id
                    })
                )
            }
            uiState = .loaded(movieUIData)
        } catch {
            uiState = .error(error.localizedDescription)
            print(error.localizedDescription)
        }
    }

    func setFavourite(movieId: Int) {
        Task {
            do {
                // 1. Extract the current movies from the Enum
                guard case .loaded(var movies) = uiState else { return }

                // 2. Optimistic Update: Change the UI state immediately
                if let index = movies.firstIndex(where: { $0.id == movieId }) {
                    movies[index].isFavorite.toggle()
                    uiState = .loaded(movies)
                }

                try await movieInteractor.toggleFavourite(movieId: movieId)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
