//
//  MovieRepository.swift
//  CoreModules
//
//  Created by Belema on 20/04/2026.
//
import Domain

final class MovieRepository: RepositoryProtocol {

    private let movieService: MovieServiceProtocol
    private let coreDataStack: CoreDataStack
    private let movieDTOMapper: MovieDTOMapper
    private let movieMapper: MovieMapper
    private let movieEntityMapper: MovieEntityMapper
    private let favoriteMovieMapper: FavouriteMovieMapper

    init(
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

    func getMovies() async throws -> [Movie] {
        let movieResponse = try await movieService.fetchPopularMovies()
        try await coreDataStack.performWrite { [movieDTOMapper] context in
            for movie in movieResponse.results {
                _ = movieDTOMapper.map(movie, context: context)
            }
        }
        return try await coreDataStack.fetchMovies().map { movie in
            movieMapper.map(movie)
        }
    }

    func getMovie(id: Int) async throws -> Movie? {
        let result = try await coreDataStack.getMovie(id: id)
        if let movie = result {
            return movieMapper.map(movie)
        }
        return nil
    }

    func addMovies(_ movies: [Movie]) async throws {
        try await coreDataStack.performWrite { [movieEntityMapper] context in
            for movie in movies {
                _ = movieEntityMapper.map(movie, context: context)
            }
        }
    }

    func addMovie(_ movie: Movie) async throws {
        try await coreDataStack.performWrite { [movieEntityMapper] context in
            _ = movieEntityMapper.map(movie, context: context)
        }
    }

    func addFavouriteMovie(_ movie: FavouriteMovie) async throws {
        try await coreDataStack.performWrite { context in
            let favMovie = FavouriteMovieEntity(context: context)
            favMovie.id = Int64(movie.id)
        }
    }

    func removeFavouriteMovie(_ movie: FavouriteMovie) async throws {
        try await coreDataStack.deleteFavouriteMovie(id: movie.id)
    }

    func getFavouriteMovies() async throws -> [FavouriteMovie] {
        let favouriteMovieEntities = try await coreDataStack.fetchFavouriteMovies()
        return favouriteMovieEntities.map { favouriteMovieEntity in
            favoriteMovieMapper.map(favouriteMovieEntity)
        }
    }
}
