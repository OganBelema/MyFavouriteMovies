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

    init(movieInteractor: MovieInteractorProtocol) {
        self.movieInteractor = movieInteractor
    }

    func loadMovies() async {
        do {
            uiState = .loading
            let movies = try await movieInteractor.getMovies()
            let favouriteIds = try await movieInteractor.getFavouriteIds()
            let movieUIData = movies.map { item in
                MovieUIData(
                    id: item.id,
                    title: item.title,
                    releaseDate: item.releaseDate,
                    overview: item.overview,
                    posterPath: item.posterPath,
                    popularity: item.popularity,
                    voteAverage: item.voteAverage,
                    isFavorite: favouriteIds.contains(item.id)
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
