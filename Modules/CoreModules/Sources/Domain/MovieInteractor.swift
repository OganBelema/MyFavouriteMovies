//
//  MovieInteractor.swift
//  CoreModules
//
//  Created by Belema on 20/04/2026.
//

public class MovieInteractor: MovieInteractorProtocol {
    private let repository: RepositoryProtocol

    public init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    public func getMovies() async throws -> [Movie] {
        try await repository.getMovies()
    }

    public func toggleFavourite(movieId: Int) async throws {
        let favouriteIds = try await getFavouriteIds()
        let isFavourite = favouriteIds.contains(movieId)

        if isFavourite {
            try await repository.removeFavouriteMovie(FavouriteMovie(id: movieId))
        } else {
            try await repository.addFavouriteMovie(FavouriteMovie(id: movieId))
        }
    }

    public func getFavourites() async throws -> [Movie] {
        let favouriteMovieIds = try await getFavouriteIds()
        return try await repository.getMovies().filter { movie in
            favouriteMovieIds.contains(movie.id)
        }
    }

    public func getFavouriteIds() async throws -> Set<Int> {
        let favouriteMovies = try await getFavouriteMovies()
        return Set(favouriteMovies.map(\.id))
    }

    private func getFavouriteMovies() async throws -> [FavouriteMovie] {
        try await repository.getFavouriteMovies()
    }
}
