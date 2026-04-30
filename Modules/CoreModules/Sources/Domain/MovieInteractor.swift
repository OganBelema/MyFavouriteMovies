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
        let movie = try await getFavourites().first(where: { favMovie in
            favMovie.id == movieId
        })

        if let movie {
            try await repository.removeFavouriteMovie(FavouriteMovie(id: movie.id))
        } else {
            try await repository.addFavouriteMovie(FavouriteMovie(id: movieId))
        }
    }

    public func getFavourites() async throws -> [Movie] {
        let favouriteMovies = try await getFavouriteMovies()
        let favouriteMovieIds = Set(favouriteMovies.map(\.id))
        return try await repository.getMovies().filter { movie in
            favouriteMovieIds.contains(movie.id)
        }
    }

    private func getFavouriteMovies() async throws -> [FavouriteMovie] {
        try await repository.getFavouriteMovies()
    }
}
