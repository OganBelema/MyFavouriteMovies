//
//  MovieRepository.swift
//  CoreModules
//
//  Created by Belema on 20/04/2026.
//
import Domain

public final class MovieRepository: RepositoryProtocol {

    private let movieService: MovieServiceProtocol
    private let coreDataStack: CoreDataStack
    private let movieDTOMapper: MovieDTOMapper
    private let movieMapper: MovieMapper
    private let movieEntityMapper: MovieEntityMapper
    private let favoriteMovieMapper: FavouriteMovieMapper

    public init(
        movieService: MovieServiceProtocol,
        coreDataStack: CoreDataStack,
        movieDTOMapper: MovieDTOMapper,
        movieMapper: MovieMapper,
        movieEntityMapper: MovieEntityMapper,
        favoriteMovieMapper: FavouriteMovieMapper
    ) {
        self.movieService = movieService
        self.coreDataStack = coreDataStack
        self.movieDTOMapper = movieDTOMapper
        self.movieMapper = movieMapper
        self.movieEntityMapper = movieEntityMapper
        self.favoriteMovieMapper = favoriteMovieMapper
    }

    public func getMovies() async throws -> [Movie] {
        let movieResponse = try await movieService.fetchPopularMovies()
        try await coreDataStack.performWrite { [movieDTOMapper] context in
            for movie in movieResponse.results {
                _ = movieDTOMapper.map(movie, context: context)
            }
        }
        return try await coreDataStack.fetchMovies(movieMapper: movieMapper)
    }

    public func getMovie(id: Int) async throws -> Movie? {
        try await coreDataStack.getMovie(id: id, movieMapper: movieMapper)
    }

    public func addMovies(_ movies: [Movie]) async throws {
        try await coreDataStack.performWrite { [movieEntityMapper] context in
            for movie in movies {
                _ = movieEntityMapper.map(movie, context: context)
            }
        }
    }

    public func addMovie(_ movie: Movie) async throws {
        try await coreDataStack.performWrite { [movieEntityMapper] context in
            _ = movieEntityMapper.map(movie, context: context)
        }
    }

    public func addFavouriteMovie(_ movie: FavouriteMovie) async throws {
        try await coreDataStack.performWrite { context in
            let favMovie = FavouriteMovieEntity(context: context)
            favMovie.id = Int64(movie.id)
        }
    }

    public func removeFavouriteMovie(_ movie: FavouriteMovie) async throws {
        try await coreDataStack.deleteFavouriteMovie(id: movie.id)
    }

    public func getFavouriteMovies() async throws -> [FavouriteMovie] {
        try await coreDataStack.fetchFavouriteMovies(favouriteMovieMapper: favoriteMovieMapper)
    }
}
